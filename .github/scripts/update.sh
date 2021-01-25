extension=$1
version=$2
case $extension in
  amqp|grpc|protobuf|propro|raphf)
  tag=$(curl -sSL "https://pecl.php.net/rest/r/$extension/allreleases.xml" | grep -m 1 -Eo "([0-9]+.[0-9]+.[0-9]+(.[0-9]+)?)(<)" | cut -d '<' -f 1)
  sed -i "s/  url .*/  url \"https\:\/\/pecl.php.net\/get\/$extension-$tag.tgz\"/g" ./Formula/"$version".rb
  ;;
  "pcov")
  tag=$(curl -SsL https://github.com/krakjoe/pcov/tags | awk '/\/tag\/v([0-9]+.[0-9]+.[0-9]+)/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
  sed -i "s/^  url .*/  url \"https\:\/\/github.com\/krakjoe\/pcov\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  "swoole")
  tag=$(curl -SsL https://github.com/swoole/swoole-src/tags | awk '/\/tag\/v([0-9]+.[0-9]+.[0-9]+)/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
  sed -i "s/^  url .*/  url \"https\:\/\/github.com\/swoole\/swoole-src\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  xdebug|igbinary|imagick)
  tag=$(curl -SsL "https://github.com/$extension/$extension/tags" | awk '/\/tag\/([0-9]+.[0-9]+.[0-9]+)">/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
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