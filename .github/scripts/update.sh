extension=$1
version=$2
case $extension in
  amqp|apcu|ast|couchbase|expect|event|gnupg|grpc|imagick|msgpack|protobuf|propro|psr|raphf|rdkafka|redis|mailparse|memcached|mcrypt|mongodb|ssh2|vips|xlswriter|yaml)
  tag=$(curl -sSL "https://pecl.php.net/rest/r/$extension/allreleases.xml" | grep -m 1 -Eo "([0-9]+.[0-9]+(.[0-9]+)?(.[0-9]+)?)(<)" | cut -d '<' -f 1)
  sed -i "s/  url .*/  url \"https\:\/\/pecl.php.net\/get\/$extension-$tag.tgz\"/g" ./Formula/"$version".rb
  ;;
  "pcov")
  tag=$(gh api /repos/krakjoe/pcov/git/refs/tags | jq -r .[].ref | cut -d '/' -f 3 | sed '/-/!{s/$/_/}' | sort -V | sed 's/_$//' | tail -1)
  sed -i "s/^  url .*/  url \"https\:\/\/github.com\/krakjoe\/pcov\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  "phalcon5")
  tag=$(curl -sSL "https://pecl.php.net/rest/r/phalcon/allreleases.xml" | grep -m 1 -Eo "([0-9]+.[0-9]+(.[0-9]+)?(.[0-9]+)?([a-zA-Z]+[0-9]+))(<)" | cut -d '<' -f 1)
  sed -i "s/  url .*/  url \"https\:\/\/pecl.php.net\/get\/phalcon-$tag.tgz\"/g" ./Formula/"$version".rb
  ;;
  "swoole")
  tag=$(curl -SsL https://github.com/swoole/swoole-src/releases/latest | grep 'swoole-src/tree' | grep -Po "v[0-9]+\.[0-9]+\.[0-9]+" | head -1)
  sed -i "s/^  url .*/  url \"https\:\/\/github.com\/swoole\/swoole-src\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  xdebug|igbinary)
  [[ "$version" =~ xdebug@(7.[2-4]|8.[0-1) ]] && regex='[0-9]+\.[0-9]+\.[0-9]+$' || regex='(^[0-9]\.).*'
  tag=$(gh api /repos/"$extension"/"$extension"/git/refs/tags | jq -r .[].ref | cut -d '/' -f 3 | grep -E "$regex" | sed '/-/!{s/$/_/}' | sort -V | sed 's/_$//' | tail -1)
  sed -i "s/^  url .*/  url \"https\:\/\/github.com\/$extension\/$extension\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  "pecl_http")
  case $version in
    pecl_http@7.*)
    tag=$(curl -sSL "https://pecl.php.net/rest/r/$extension/allreleases.xml" | grep -m 1 -Eo "(3.[0-9]+.[0-9]+(.[0-9]+)?)(<)" | cut -d '<' -f 1)
    sed -i "s/^  url .*/  url \"https\:\/\/pecl.php.net\/get\/$extension-$tag.tgz\"/g" ./Formula/"$version".rb
    ;;
    pecl_http@8.*)
    tag=$(curl -sSL "https://pecl.php.net/rest/r/$extension/allreleases.xml" | grep -m 1 -Eo "(4.[0-9]+.[0-9]+(.[0-9]+)?)(<)" | cut -d '<' -f 1)
    sed -i "s/^  url .*/  url \"https\:\/\/pecl.php.net\/get\/$extension-$tag.tgz\"/g" ./Formula/"$version".rb
  esac
  ;;
esac