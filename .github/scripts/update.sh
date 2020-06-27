extension=$1
version=$2
case $extension in
  grpc|protobuf)
  tag=$(curl -sSL "https://pecl.php.net/rest/r/$extension/allreleases.xml" | grep -m 1 -Eo "([0-9]+.[0-9]+.[0-9]+)")
  sed -i '' "s/.*tgz.*/  url \"https\:\/\/pecl.php.net\/get\/$extension-$tag.tgz\"/g" ./Formula/"$version".rb
  ;;
  "pcov")
  tag=$(curl -SsL https://github.com/krakjoe/pcov/tags | awk '/\/tag\/v([0-9]+.[0-9]+.[0-9]+)/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
  sed -i '' "s/.*tar.gz.*/  url \"https\:\/\/github.com\/krakjoe\/pcov\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  "swoole")
  tag=$(curl -SsL https://github.com/swoole/swoole-src/tags | awk '/\/tag\/v([0-9]+.[0-9]+.[0-9]+)/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
  sed -i '' "s/.*tar.gz.*/  url \"https\:\/\/github.com\/swoole/swoole-src\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
  "xdebug")
  tag=$(curl -SsL https://github.com/xdebug/xdebug/tags | awk '/\/tag\/([0-9]+.[0-9]+.[0-9]+)/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
  sed -i '' "s/.*tar.gz.*/  url \"https\:\/\/github.com\/xdebug\/xdebug\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
  ;;
esac