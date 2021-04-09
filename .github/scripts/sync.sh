brew tap shivammathur/extensions
mapfile -t extensions < <(find "$(brew --repository)"/Library/Taps/shivammathur/homebrew-extensions/Formula -name "*.rb" -print0 | xargs -0 basename -a | sed "s/@.*//" | sort | uniq)
to_wait=()
for extension in "${extensions[@]}"; do
  deps=
  sudo mkdir -p "./.github/deps/$extension"
  mapfile -t deps < <(grep "depends_on" "$(brew --repository)"/Library/Taps/shivammathur/homebrew-extensions/Formula/"$extension"@7.4.rb | tr -d '"' | cut -d' ' -f 4)
  for formula in "${deps[@]}"; do
    curl -o "./.github/deps/$extension/$formula.rb" -sL "https://raw.githubusercontent.com/Homebrew/homebrew-core/master/Formula/$formula.rb" &
    to_wait+=($!)
  done
done
wait "${to_wait[@]}"
ls "./.github/deps/$extension"
if [ "$(git status --porcelain=v1 2>/dev/null | wc -l)" != "0" ]; then
  git config --local user.email 1589480+BrewTestBot@users.noreply.github.com
  git config --local user.name BrewTestBot
  git config --local pull.rebase true
  git stash
  git pull -f https://"$GITHUB_REPOSITORY_OWNER":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPOSITORY".git master
  git stash apply || true
  if [ "$(git status --porcelain=v1 2>/dev/null | wc -l)" != "0" ]; then
    git add .
    git commit -m "Update extension dependencies"
    git push -f https://"$GITHUB_REPOSITORY_OWNER":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPOSITORY".git master || true
  fi
fi
