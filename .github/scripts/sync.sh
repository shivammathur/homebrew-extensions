# configure git
git config --local user.email 1589480+BrewTestBot@users.noreply.github.com
git config --local user.name BrewTestBot
git config --local pull.rebase true

brew tap shivammathur/php

trunk=https://raw.githubusercontent.com/Homebrew/homebrew-core/main/Formula
IFS=' ' read -r -a extensions <<<"$(find ./Formula -maxdepth 1 -name '*@*.rb' -print0 | xargs -0 basename -a | sed 's/@.*//' | sort | uniq | tr '\n' ' ')"
for extension in "${extensions[@]}"; do
  formula_file=./Formula/"$extension"@7.2.rb
  if ! [ -e "$formula_file" ]; then
    formula_file=./Formula/"$extension"@7.4.rb
  fi
  if [ -e "$formula_file" ]; then
    IFS=' ' read -r -a deps <<<"$(brew deps --formula "$formula_file" | tr '\n' ' ')"
    
    if [[ -n "${deps// }" ]]; then
      printf "\n----- %s -----\n" "$extension"
      echo "${deps[@]//shivammathur*}"
      sudo rm -rf "./.github/deps/$extension"
      sudo mkdir -p "./.github/deps/$extension"
      for formula in "${deps[@]//shivammathur*}"; do
        [ "$formula" = "python" ] && continue;
        if [ "x$formula" != "x" ]; then
          [[ ${formula:0:3} == "lib" ]] && prefix=lib || prefix="${formula:0:1}"
          sudo mkdir -p "./.github/deps/$extension/$prefix"
          sudo curl -o "./.github/deps/$extension/$prefix/$formula.rb" -sL "$trunk"/"$prefix"/"$formula".rb
          grep -q "Formula" "./.github/deps/$extension/$prefix/$formula.rb" || exit 1
        fi
      done
      ls -R "./.github/deps/$extension"
    fi  
  fi
done
sudo git status
sudo git add .
if [ "$(git status --porcelain=v1 2>/dev/null | wc -l)" != "0" ]; then
  sudo git stash
  sudo git pull -f https://"$GITHUB_REPOSITORY_OWNER":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPOSITORY".git main
  sudo git stash apply
  sudo git add .
  sudo git commit -m "Update extension dependencies"
  sudo git push -f https://"$GITHUB_REPOSITORY_OWNER":"$GITHUB_TOKEN"@github.com/"$GITHUB_REPOSITORY".git main || true
fi
