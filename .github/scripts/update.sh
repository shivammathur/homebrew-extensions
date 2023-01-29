extension=$1
version=$2
case $extension in
  amqp|apcu|ast|couchbase|ds|expect|event|gearman|gnupg|grpc|imagick|lua|msgpack|protobuf|propro|psr|raphf|rdkafka|redis|mailparse|memcached|mcrypt|mongodb|ssh2|sqlsrv|pdo_sqlsrv|uuid|vips|xlswriter|yaml)
  tag=$(curl -sSL "https://pecl.php.net/rest/r/$extension/allreleases.xml" | grep -m 1 -Eo "([0-9]+.[0-9]+(.[0-9]+)?(.[0-9]+)?)(<)" | cut -d '<' -f 1)
  sed -i "s/  url .*/  url \"https\:\/\/pecl.php.net\/get\/$extension-$tag.tgz\"/g" ./Formula/"$version".rb
  ;;
  "pcov")
  tag=$(gh api /repos/krakjoe/pcov/git/refs/tags | jq -r .[].ref | cut -d '/' -f 3 | sed '/-/!{s/$/_/}' | sort -V | sed 's/_$//' | tail -1)
  sed -i "s/^  url .*/  url \"https\:\/\/github.com\/krakjoe\/pcov\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  "phalcon5")
  tag=$(curl -sSL "https://pecl.php.net/rest/r/phalcon/allreleases.xml" | grep -m 1 -Eo "([0-9]+.[0-9]+(.[0-9]+)?(.[0-9]+)?)(<)" | cut -d '<' -f 1)
  sed -i "s/  url .*/  url \"https\:\/\/pecl.php.net\/get\/phalcon-$tag.tgz\"/g" ./Formula/"$version".rb
  ;;
  "swoole")
  tag=$(curl -SsL https://github.com/swoole/swoole-src/releases/latest | grep 'swoole-src/tree' | grep -Po "v[0-9]+\.[0-9]+\.[0-9]+" | head -1)
  sed -i "s/^  url .*/  url \"https\:\/\/github.com\/swoole\/swoole-src\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  xdebug|igbinary)
  pip3 install packaging
  [[ "$version" =~ xdebug@(8.[0-2]) ]] && regex='[0-9]+\.[0-9]+\.[0-9]+$' || regex='(^[0-9]\.).*'
  tags=$(gh api /repos/"$extension"/"$extension"/git/refs/tags | jq -r .[].ref | cut -d '/' -f 3 | grep -E "$regex" | sed -z 's/\n/","/g;s/,$/\n/' | sed -E 's|","$||g')
  tag=$(python3 -c "from packaging import version; print(sorted([\"$tags\"], key=lambda x: version.Version(x))[-1])")
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