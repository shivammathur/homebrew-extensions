get_php_url() {
  php_version=$(echo "$version" | cut -d'@' -f2)
  brew tap -q shivammathur/php
  brew cat shivammathur/php/php@"$php_version" | grep -e "^  url.*" | cut -d\" -f 2
}

get_formula_branch() {
  local formula=$1
  grep -oE 'branch: "[^"]+"' ./Formula/"$formula".rb | sed 's/branch: "//;s/"//'
}

get_head_commit() {
  local branch=$1
  local repo=$2
  curl -H "Authorization: Bearer $GITHUB_TOKEN" -sL "https://api.github.com/repos/${repo#https://github.com/}/commits/$branch" | sed -n 's|^  "sha":.*"\([a-f0-9]*\)",|\1|p'
}

patch_github_commit() {
  local commit=$1
  local repo=$2
  local suffix=""
  if grep -q "\\?commit=" ./Formula/"$version".rb; then
    suffix="?commit=$commit"
  fi
  sed -i.bak "s|^  url .*|  url \"$repo/archive/$commit.tar.gz$suffix\"|g" ./Formula/"$version".rb
  rm -f ./Formula/"$version".rb.bak
}

patch_php_url() {
  local php_url=$1
  sed -i.bak "s|^  url.*|  url \"$php_url\"|g" ./Formula/"$version".rb
  rm -f ./Formula/"$version".rb.bak
}

extension=$1
version=$2
repo=$3

case $version in
  imap@5.6|imap@7.[0-4]|imap@8.0|\
  interbase@5.6|interbase@7.[0-2]|\
  mcrypt@5.6|mcrypt@7.[0-1]|\
  pdo_firebird@5.6|pdo_firebird@7.[0-4]|pdo_firebird@8.0|\
  snmp@5.6|snmp@7.[0-4]|snmp@8.0)
    php_url=$(get_php_url)
    patch_php_url "$php_url"
    ;;
  pdo_firebird@8.6|\
  scalar_objects@7.[0-4]|scalar_objects@8.[0-6]|\
  v8js@7.[0-4]|v8js@8.[0-6]|\
  xdebug@8.6|\
  zmq@5.6|zmq@7.[0-4]|zmq@8.[0-6])
    branch="$(get_formula_branch "$version")"
    commit="$(get_head_commit "$branch" "$repo")"
    patch_github_commit "$commit" "$repo"
    ;;
esac
