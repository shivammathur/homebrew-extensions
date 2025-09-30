get_latest_remote_git_tag() {
  local repo=$1
  local major_version=$2
  [[ -n "$major_version" ]] && regex="$major_version\." || regex="[0-9]\."
  git ls-remote --tags --sort="v:refname" "$repo" | sed 's/.*\///' | grep -Eo "^v?$regex[0-9]+\.[0-9]+$" | tail -n1
}

get_latest_pecl_tag() {
  local extension=$1
  local major_version=$2
  [[ -n "$major_version" ]] && regex="$major_version." || regex=""
  curl -sSL "https://pecl.php.net/rest/r/$extension/allreleases.xml" | grep -Eo "($regex[0-9]+.[0-9]+(.[0-9]+)?(.[0-9]+)?)(<)" | cut -d '<' -f 1 | sort -V | tail -n1
}

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
  curl -H "Authorization: Brearer $GITHUB_TOKEN" -sL "https://api.github.com/repos/${repo#https://github.com/}/commits/$branch" | sed -n 's|^  "sha":.*"\([a-f0-9]*\)",|\1|p'
}

patch_pecl_tag() {
  local tag=$1
  local extension=$2
  sed -i "s/^  url .*/  url \"https\:\/\/pecl.php.net\/get\/$extension-$tag.tgz\"/g" ./Formula/"$version".rb
}

patch_github_tag() {
  local tag=$1
  local repo=$2
  sed -i "s|^  url .*|  url \"$repo/archive/$tag.tar.gz\"|g" ./Formula/"$version".rb
}

patch_php_url() {
  local php_url=$1
  sed -i "s|^  url.*|  url \"$php_url\"|g" ./Formula/"$version".rb
}

extension=$1
version=$2
repo=$3
case $extension in
  amqp|apcu|ast|couchbase|ds|expect|event|gearman|gnupg|grpc|imagick|lua|msgpack|protobuf|propro|psr|raphf|rdkafka|redis|mailparse|memcache|memcached|mongodb|ssh2|sqlsrv|pdo_sqlsrv|uuid|vips|xlswriter|yaml)
    tag=$(get_latest_pecl_tag "$extension")
    patch_pecl_tag "$tag" "$extension"
    ;;
  igbinary|pcov|swoole|vld)
    tag="$(get_latest_remote_git_tag "$repo")"
    patch_github_tag "$tag" "$repo"
    ;;
  imap|snmp)
    if [[ $extension = "snmp" || "$version" =~ imap@(5.6|7.[0-4]|8.[0-3]) ]]; then
      php_url=$(get_php_url)
      patch_php_url "$php_url"
    else
      tag=$(get_latest_pecl_tag "$extension")
      patch_pecl_tag "$tag" "$extension"
    fi  
  ;;
  "phalcon5")
    tag=$(get_latest_pecl_tag "phalcon")
    patch_pecl_tag "$tag" "phalcon"
    ;;
  "xdebug")
    if [[ "$version" = "xdebug@8.5" || "$version" = "xdebug@8.6" ]]; then
      branch="$(get_formula_branch "$version")"
      tag="$(get_head_commit "$branch" "$repo")"
    else
      [[ "$version" =~ xdebug@(8.[0-4]) ]] && major_version=3 || major_version=2
      tag="$(get_latest_remote_git_tag "$repo" "$major_version")"
    fi
    patch_github_tag "$tag" "$repo"
    ;;
  "pecl_http")
    [[ "$version" =~ pecl_http@7.* ]] && major_version=3 || major_version=4
    tag=$(get_latest_pecl_tag "$extension" "$major_version")
    patch_pecl_tag "$tag" "$extension"
    ;;
  "mcrypt")
    case $version in
      mcrypt@5.6|mcrypt@7.0|mcrypt@7.1)
        php_url=$(get_php_url)
        patch_php_url "$php_url"
      ;;
      *)
        tag=$(get_latest_pecl_tag "$extension")
        patch_pecl_tag "$tag" "$extension"
    esac
esac
