git config --global user.name "BrewTestBot"
git config --global user.email "1589480+BrewTestBot@users.noreply.github.com"
for formula in ./Formula/"$EXTENSION"@*.rb; do
  VERSION="$EXTENSION"@"$(echo "$formula" | grep -Eo '[0-9]+\.[0-9]+')"
  export VERSION
  git checkout "$GITHUB_DEFAULT_BRANCH" || true
  git checkout -b "update-$VERSION-${GITHUB_SHA:0:7}"
  bash .github/scripts/edit.sh
  if ! git diff --quiet --exit-code; then
    git add "$formula"
    git commit -m "Update $VERSION"
    gh pr create --title "Update $VERSION" \
                 --body "Build $VERSION" \
                 --base "$GITHUB_DEFAULT_BRANCH" \
                 --assignee "$GITHUB_REPOSITORY_OWNER" \
                 --label "$VERSION" --label "automated-pr"
  fi
done
