extension=$1
version=$2
if [ "$extension" = "xdebug" ]; then
  tag=$(curl -SsL https://github.com/xdebug/xdebug/tags | awk '/\/tag\/([0-9]+.[0-9]+.[0-9]+)/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
  sed -i '' "s/.*tar.gz.*/  url \"https\:\/\/github.com\/xdebug\/xdebug\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
elif [ "$extension" = "swoole" ]; then
  tag=$(curl -SsL https://github.com/swoole/swoole-src/tags | awk '/\/tag\/v([0-9]+.[0-9]+.[0-9]+)/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
  sed -i '' "s/.*tar.gz.*/  url \"https\:\/\/github.com\/swoole/swoole-src\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
elif [ "$extension" = "pcov" ]; then
  tag=$(curl -SsL https://github.com/krakjoe/pcov/tags | awk '/\/tag\/v([0-9]+.[0-9]+.[0-9]+)/' | cut -d '"' -f 2 | awk '{n=split($NF,a,"/");print a[n]}' | head -n 1)
  sed -i '' "s/.*tar.gz.*/  url \"https\:\/\/github.com\/krakjoe\/pcov\/archive\/$tag.tar.gz\"/g" ./Formula/"$version".rb
fi