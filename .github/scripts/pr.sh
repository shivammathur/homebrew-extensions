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
    bash .github/scripts/retry.sh 10 5 gh pr create --title "Update $VERSION" \
                 --body "Build $VERSION" \
                 --base "$GITHUB_DEFAULT_BRANCH" \
                 --assignee "$GITHUB_REPOSITORY_OWNER"
  fi
done
