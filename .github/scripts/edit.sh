unbottle() {
  sed -Ei 's/\?init=true//' ./Formula/"$VERSION".rb || true
}

fetch() {
  sudo cp "Formula/$VERSION.rb" "/tmp/$VERSION.rb"
  [[ "$GITHUB_MESSAGE" =~ .*--init.* ]] && return
  if [[ "$EXTENSION" =~ imap ]]; then
    php_version=$(echo "$VERSION" | cut -d'@' -f2)
    brew tap shivammathur/php
    php_url=$(brew cat shivammathur/php/php@"$php_version" | grep -e "^  url.*" | cut -d\" -f 2)
    checksum=$(curl -sSL "$php_url" | shasum -a 256 | cut -d' ' -f 1)
    sed -i "s|^  url.*|  url \"$php_url\"|g" ./Formula/"$VERSION".rb
    [ "$checksum" != "" ] && sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
  else
    if [[ "$EXTENSION" =~ amqp|expect|gnupg|pcov|imagick ]] ||
       [[ "$VERSION" =~ (propro)@7.[0-4] ]] ||
       [[ "$VERSION" =~ (pecl_http|msgpack)@(7.[0-4]|8.0) ]] ||
       [[ "$VERSION" =~ (apcu|grpc|igbinary|mailparse|protobuf|raphf|rdkafka|redis|ssh2|vips|xlswriter)@(7.[0-4]|8.[0-2]) ]] ||
       [[ "$VERSION" =~ (yaml)@(7.[1-4]|8.[0-2]) ]] ||
       [[ "$VERSION" =~ (mongodb|swoole|xdebug)@(7.[2-4]|8.[0-2]) ]] ||
       [[ "$VERSION" =~ (psr)@(7.[3-4]|8.[0-2]) ]] ||
       [[ "$VERSION" =~ (memcache)@8.[0-2] ]]; then
      sudo chmod a+x .github/scripts/update.sh && bash .github/scripts/update.sh "$EXTENSION" "$VERSION"
      url=$(grep '  url' < ./Formula/"$VERSION".rb | cut -d\" -f 2)
      checksum=$(curl -sSL "$url" | shasum -a 256 | cut -d' ' -f 1)
      sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
    fi
  fi
}

check_changes() {
  new_url="$(grep -e "^  url.*" ./Formula/"$VERSION".rb | cut -d\" -f 2)"
  old_url="$(grep -e "^  url.*" /tmp/"$VERSION".rb | cut -d\" -f 2)"
  new_checksum="$(grep -e "^  sha256.*" ./Formula/"$VERSION".rb | cut -d\" -f 2)"
  old_checksum="$(grep -e "^  sha256.*" /tmp/"$VERSION".rb | cut -d\" -f 2)"
  echo "new_url: $new_url"
  echo "old_url: $old_url"
  echo "new_checksum: $new_checksum"
  echo "old_checksum: $old_checksum"
  if [ "$new_url" = "$old_url" ] &&
     [ "$new_checksum" = "$old_checksum" ] &&
     [[ ! "$GITHUB_MESSAGE" =~ .*--(rebuild|init).* ]]; then
    sudo cp /tmp/"$VERSION".rb Formula/"$VERSION".rb
  else
    unbottle
  fi
}

fetch
check_changes
