unbottle() {
  sed -Ei 's/\?init=true//' ./Formula/"$VERSION".rb || true
}

join() { local IFS="$1"; shift; echo "$*"; }

add_labels() {
  if [[ "$EXTENSION" =~ imap ]]; then
    echo "::set-output name=labels::CI-no-linux"
  fi

  init_labels=()
  if [[ "$GITHUB_MESSAGE" =~ .*--init.* ]]; then
    if ! [[ "$GITHUB_MESSAGE" =~ .*--skip-arm.* ]]; then
      init_labels+=("CI-force-arm")
    fi
    if ! [[ "$GITHUB_MESSAGE" =~ .*--skip-linux.* ]]; then
      init_labels+=("CI-force-linux")
    fi
    echo "::set-output name=labels::$(join , "${init_labels[@]}")"
  fi
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
    if [[ "$EXTENSION" =~ pcov|imagick ]] ||
       [[ "$VERSION" =~ (memcache)@8.[0-1] ]] ||
       [[ "$VERSION" =~ (propro)@7.[0-4] ]] ||
       [[ "$VERSION" =~ (swoole|xdebug)@(7.[2-4]|8.[0-1]) ]] ||
       [[ "$VERSION" =~ (mongodb|yaml)@(7.[1-4]|8.[0-1]) ]] ||
       [[ "$VERSION" =~ (apcu|pecl_http|msgpack)@(7.[0-4]|8.0]) ]] ||
       [[ "$VERSION" =~ (grpc|igbinary|protobuf|psr|raphf|rdkafka|redis|vips)@(7.[0-4]|8.[0-1]) ]] ||
       [[ "$VERSION" =~ amqp@(5.6|7.[0-4]) ]]; then
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
add_labels