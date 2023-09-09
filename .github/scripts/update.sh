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
  igbinary|pcov|swoole)
    tag="$(get_latest_remote_git_tag "$repo")"
    patch_github_tag "$tag" "$repo"
    ;;
  imap|snmp)
    php_url=$(get_php_url)
    patch_php_url "$php_url"
  ;;
  "phalcon5")
    tag=$(get_latest_pecl_tag "phalcon")
    patch_pecl_tag "$tag" "phalcon"
    ;;
  "xdebug")
    [[ "$version" =~ xdebug@(8.[0-3]) ]] && major_version=3 || major_version=2
    tag="$(get_latest_remote_git_tag "$repo" "$major_version")"
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
