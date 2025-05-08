# Script to generate formula files for new extension.
# Edit update.sh for the new formula and run this script.

extension=$1
repo=$2
branch=$3
license=$4
type=$5
shift 5
versions=("$@")
title="$(tr '[:lower:]' '[:upper:]' <<< "${extension:0:1}")${extension:1}"
for version in "${versions[@]}"; do
  echo "------ $version ------"
  file=./Formula/"$extension@$version.rb"
  sudo cp .github/formula_templates/extension.rb.stub "$file"
  sed -i "s/Extension_TitleAT/${title}AT/" "$file"
  sed -i "s/NODOT/${version/./}/g" "$file"
  sed -i "s/Extension_Title PHP extension/$title PHP extension/" "$file"
  sed -i "s|REPO|$repo|" "$file"
  sed -i "s|REPO_BRANCH|$branch|" "$file"
  if [ "$license" != 'no' ]; then
    sed -i "s/LICENSE_NAME/$license/" "$file"
  else
    sed -i 's/"LICENSE_NAME"/:cannot_represent/' "$file"
  fi
  sed -i "s/Class for Extension_Title/Class for $title/" "$file"
  sed -i "s/--enable-extension/--enable-$extension/" "$file"
  sed -i "s/extension.so/$extension.so/" "$file"
  if [ "$type" = 'pecl' ]; then
    sed -i "s/CHDIR/Dir.chdir \"$extension-#{version}\"/" "$file"
  elif [ "$type" = 'php' ]; then
    sed -i "s/CHDIR/Dir.chdir \"ext/#{extension}\"/" "$file"
  else
    sed -i '/CHDIR/d' "$file"
  fi
  bash .github/scripts/update.sh "$extension" "$extension@$version" "https://github.com/$repo"
  url=$(grep '  url' < "$file" | cut -d\" -f 2)
  checksum=$(curl -sSL "$url" | shasum -a 256 | cut -d' ' -f 1)
  sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" "$file"
  echo "Generated $extension@$version.rb"
done