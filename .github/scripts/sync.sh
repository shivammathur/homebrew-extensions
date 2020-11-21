extension=$1
shift
deps=("$@")
git config --local user.email homebrew-test-bot@lists.sfconservancy.org
git config --local user.name BrewTestBot
git config --local pull.rebase true

sudo mkdir -p "./.github/deps/$extension"
for formula in "${deps[@]}"; do
  sudo cp "$(brew --prefix)/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/$formula.rb" "./.github/deps/$extension/"
done
ls "./.github/deps/$extension"
if [ "$(git status --porcelain=v1 2>/dev/null | wc -l)" != "0" ]; then
  git stash
  git pull -f https://"$GITHUB_REPOSITORY_OWNER":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPOSITORY".git master
  git stash apply || true
  if [ "$(git status --porcelain=v1 2>/dev/null | wc -l)" != "0" ]; then
    git add .
    git commit -m "Update PHP dependencies for $extension"
    git push -f https://"$GITHUB_REPOSITORY_OWNER":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPOSITORY".git master || true
  fi
fi
