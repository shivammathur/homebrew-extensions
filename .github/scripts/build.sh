tick="✓"
cross="✗"

step_log() {
  message=$1
  printf "\n\033[90;1m==> \033[0m\033[37;1m%s\033[0m\n" "$message"
}

add_log() {
  mark=$1
  subject=$2
  message=$3
  if [ "$mark" = "$tick" ]; then
    printf "\033[32;1m%s \033[0m\033[34;1m%s \033[0m\033[90;1m%s\033[0m\n" "$mark" "$subject" "$message"
  else
    printf "\033[31;1m%s \033[0m\033[34;1m%s \033[0m\033[90;1m%s\033[0m\n" "$mark" "$subject" "$message"
  fi
}

step_log "Housekeeping"
unset HOMEBREW_DISABLE_LOAD_FORMULA
brew update-reset "$(brew --repository)" >/dev/null 2>&1
add_log "$tick" "Housekeeping" "Done"

step_log "Adding tap $GITHUB_REPOSITORY"
mkdir -p "$(brew --prefix)/Homebrew/Library/Taps/$HOMEBREW_BINTRAY_USER"
ln -s "$PWD" "$(brew --prefix)/Homebrew/Library/Taps/$GITHUB_REPOSITORY"
add_log "$tick" "$GITHUB_REPOSITORY" "Tap added to brewery"

step_log "Checking label"
package="${VERSION//@/:}"
new_version=$(brew info Formula/"$VERSION".rb | head -n 1 | cut -d',' -f 1 | cut -d' ' -f 3)
existing_version=$(curl --user "$HOMEBREW_BINTRAY_USER":"$HOMEBREW_BINTRAY_KEY" -s https://api.bintray.com/packages/"$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO"/"$package" | sed -e 's/^.*"latest_version":"\([^"]*\)".*$/\1/')

if [[ "$EXTENSION" =~ grpc|pcov|protobuf ]] ||
   [[ "$VERSION" =~ swoole@7.[1-4] ]] ||
   [[ "$VERSION" =~ xdebug@7.[2-4] ]]; then
  sudo chmod a+x .github/scripts/update.sh && bash .github/scripts/update.sh "$EXTENSION" "$VERSION"
  url=$(grep '  url' < ./Formula/"$VERSION".rb | cut -d\" -f 2)
  checksum=$(curl -sSL "$url" | shasum -a 256 | cut -d' ' -f 1)
  sed -i '' "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
  new_version=$(brew info Formula/"$VERSION".rb | head -n 1 | cut -d',' -f 1 | cut -d' ' -f 3)
fi
echo "existing label: $existing_version"
echo "new label: $new_version"

if [[ "$GITHUB_MESSAGE" = *--build-all* ]] || [ "$new_version" != "$existing_version" ] || [ "$VERSION" = "xdebug@8.0" ]; then
  step_log "Filling the Bottle"
  sudo ln -sf "$PWD" "$(brew --prefix)/Homebrew/Library/Taps/$GITHUB_REPOSITORY"
  brew test-bot "$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO"/"$VERSION" --root-url=https://dl.bintray.com/"$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO" --skip-setup --skip-recursive-dependents
  LC_ALL=C find . -type f -name '*.json' -exec sed -i '' s~homebrew/bottles-extensions~"$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO"~ {} +
  LC_ALL=C find . -type f -name '*.json' -exec sed -i '' s~bottles-extensions~extensions~ {} +
  LC_ALL=C find . -type f -name '*.json' -exec sed -i '' s~bottles~extensions~ {} +
  cat -- *.json
  add_log "$tick" "$VERSION" "Bottle filled"

  step_log "Adding label"
  curl \
  --user "$HOMEBREW_BINTRAY_USER":"$HOMEBREW_BINTRAY_KEY" \
  --header "Content-Type: application/json" \
  --data " \
  {\"name\": \"$package\", \
  \"vcs_url\": \"$GITHUB_REPOSITORY\", \
  \"licenses\": [\"MIT\"], \
  \"public_download_numbers\": true, \
  \"public_stats\": true \
  }" \
  https://api.bintray.com/packages/"$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO" >/dev/null 2>&1 || true
  add_log "$tick" "$package" "Bottle labeled"

  step_log "Stocking the new Bottle"
  if [ "$(find . -name '*.json' | wc -l 2>/dev/null | wc -l)" != "0" ]; then
    curl --user "$HOMEBREW_BINTRAY_USER":"$HOMEBREW_BINTRAY_KEY" -X DELETE https://api.bintray.com/packages/"$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO"/"$package"/versions/"$new_version"
    brew test-bot --ci-upload --tap="$GITHUB_REPOSITORY" --root-url=https://dl.bintray.com/"$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO" --bintray-org="$HOMEBREW_BINTRAY_USER"
    curl --user "$HOMEBREW_BINTRAY_USER":"$HOMEBREW_BINTRAY_KEY" -X POST https://api.bintray.com/content/"$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO"/"$package"/"$new_version"/publish
    add_log "$tick" "$VERSION" "Bottle added to stock"

    step_log "Updating inventory"
    git config --local user.email homebrew-test-bot@lists.sfconservancy.org
    git config --local user.name BrewTestBot    
    for try in $(seq 10); do
      echo "try: $try" >/dev/null
      git fetch origin master && git rebase origin/master
      if git push https://"$GITHUB_REPOSITORY_OWNER":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPOSITORY".git HEAD:master --follow-tags; then
        break
      else
        sleep 3s
      fi
    done
  else
    add_log "$cross" "bottle" "broke"
  fi    
else
  add_log "$tick" "$VERSION $new_version" "Bottle exists"
fi