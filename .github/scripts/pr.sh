# TODO: Remove this once the GitHub Actions image is updated
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update
sudo apt-get install gh -y

git config --global user.name "BrewTestBot"
git config --global user.email "1589480+BrewTestBot@users.noreply.github.com"
for formula in ./Formula/"$EXTENSION"@*.rb; do
  VERSION="$EXTENSION"@"$(echo "$formula" | grep -Eo '[0-9]+\.[0-9]+')"
  BRANCH="update-$VERSION-${GITHUB_SHA:0:7}"
  export VERSION
  git checkout "$GITHUB_DEFAULT_BRANCH" || true
  git checkout -b "$BRANCH"
  bash .github/scripts/edit.sh
  if ! git diff --exit-code; then
    git add "$formula"
    git commit -m "Update $VERSION"
    git push origin "$BRANCH"
    gh label list | grep "$VERSION" || gh label create "$VERSION"
    gh pr create --title "Update $VERSION" \
                 --body "Build $VERSION" \
                 --base "$GITHUB_DEFAULT_BRANCH" \
                 --assignee "$GITHUB_REPOSITORY_OWNER" \
                 --label "$VERSION" --label "automated-pr"
  fi
done
