unbottle() {
  sed -Ei '/    rebuild.*/d' ./Formula/"$VERSION".rb
  sed -Ei '/    sha256.*=> :catalina$/d' ./Formula/"$VERSION".rb || true
  sed -Ei '/    sha256.*=> :arm64_big_sur$/d' ./Formula/"$VERSION".rb || true
}

create_package() {
  package="${VERSION//@/:}"
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
}

fetch() {
  sudo cp "Formula/$VERSION.rb" "/tmp/$VERSION.rb"
  if [[ "$EXTENSION" =~ imap ]]; then
    php_version=$(echo "$package" | cut -d':' -f2)
    brew tap shivammathur/php
    php_url=$(brew cat shivammathur/php/php@"$php_version" | grep -e "^  url.*" | cut -d\" -f 2)
    checksum=$(curl -sSL "$php_url" | shasum -a 256 | cut -d' ' -f 1)
    if [[ "$php_url" = *build_time* ]]; then
      sed -i "s|build_time.*|build_time=$(date +%s)\"|g" ./Formula/"$VERSION".rb
    else
      sed -i "s|^  url.*|  url \"$php_url\"|g" ./Formula/"$VERSION".rb
    fi
    [ "$checksum" != "" ] && sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
  else
    if [[ "$EXTENSION" =~ pcov ]] ||
       [[ "$VERSION" =~ protobuf@7.[0-4] ]] ||
       [[ "$VERSION" =~ swoole@(7.[1-4]|8.[0-1]) ]] ||
       [[ "$VERSION" =~ xdebug@(7.[3-4]|8.[0-1]) ]] ||
       [[ "$VERSION" =~ (grpc|igbinary)@(7.[0-4]|8.[0-1]) ]] ||
       [[ "$VERSION" =~ amqp@(5.6|7.[0-4]) ]] ||
       [[ "$VERSION" =~ imagick@(5.6|7.[0-4]) ]]; then
      sudo chmod a+x .github/scripts/update.sh && bash .github/scripts/update.sh "$EXTENSION" "$VERSION"
      url=$(grep '  url' < ./Formula/"$VERSION".rb | cut -d\" -f 2)
      checksum=$(curl -sSL "$url" | shasum -a 256 | cut -d' ' -f 1)
      sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
    fi
  fi
  check_version
}

check_version() {
  new_version=$(grep -Eo "[0-9]+\.[0-9]+\.[0-9]+" Formula/"$VERSION".rb | head -n 1)
  existing_version=$(curl --user "$HOMEBREW_BINTRAY_USER":"$HOMEBREW_BINTRAY_KEY" -s https://api.bintray.com/packages/"$HOMEBREW_BINTRAY_USER"/"$HOMEBREW_BINTRAY_REPO"/"$package" | sed -e 's/^.*"latest_version":"\([^"]*\)".*$/\1/')
  latest_version=$(printf "%s\n%s" "$new_version" "$existing_version" | sort | tail -n 1)
  echo "existing label: $existing_version"
  echo "latest label: $latest_version"
  if ! [[ "$GITHUB_MESSAGE" = *--build-all* ]] && [ "$latest_version" = "$existing_version" ] && ! [[ "$VERSION" =~ .*@8.1 ]]; then
    sudo cp /tmp/"$VERSION".rb Formula/"$VERSION".rb
  else
    unbottle
  fi
}

match_args() {
  IFS=' ' read -r -a args <<< "$GITHUB_MESSAGE"
  for arg in "${args[@]}"; do
    if [[ "$arg" =~ --build-only-"$EXTENSION"$ ]]; then
      fetch
      check_version
      break
    fi
  done
}

create_package
if [[ "$GITHUB_MESSAGE" = *--build-only* ]]; then
  match_args
else
  fetch
fi
