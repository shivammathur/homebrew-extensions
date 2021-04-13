unbottle() {
  sed -Ei 's/\?init=true//' ./Formula/"$VERSION".rb || true
  sed -Ei '/    rebuild.*/d' ./Formula/"$VERSION".rb || true
  sed -Ei '/    sha256.*catalina/d' ./Formula/"$VERSION".rb || true
  sed -Ei '/    sha256.*big_sur/d' ./Formula/"$VERSION".rb || true
  sed -Ei '/    sha256.*arm64_big_sur/d' ./Formula/"$VERSION".rb || true
}

fetch() {
  sudo cp "Formula/$VERSION.rb" "/tmp/$VERSION.rb"
  if [[ "$EXTENSION" =~ imap ]]; then
    php_version=$(echo "$package" | cut -d':' -f2)
    brew tap shivammathur/php
    php_url=$(brew cat shivammathur/php/php@"$php_version" | grep -e "^  url.*" | cut -d\" -f 2)
    checksum=$(curl -sSL "$php_url" | shasum -a 256 | cut -d' ' -f 1)
    if [[ "$php_url" = *build_time* ]]; then
      sed -i "s|build_time.*|build_time=$(date +%s)\"|g" ./Formula/"$VERSION".rb
    else
      sed -i "s|^  url.*|  url \"$php_url\"|g" ./Formula/"$VERSION".rb
    fi
    [ "$checksum" != "" ] && sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
  else
    if [[ "$EXTENSION" =~ pcov ]] ||
       [[ "$VERSION" =~ (protobuf|propro)@7.[0-4] ]] ||
       [[ "$VERSION" =~ (swoole|xdebug)@(7.[2-4]|8.[0-1]) ]] ||
       [[ "$VERSION" =~ (apcu|grpc|igbinary|msgpack|pecl_http|psr|raphf|redis)@(7.[0-4]|8.[0-1]) ]] ||
       [[ "$VERSION" =~ amqp@(5.6|7.[0-4]) ]]; then
      sudo chmod a+x .github/scripts/update.sh && bash .github/scripts/update.sh "$EXTENSION" "$VERSION"
      url=$(grep '  url' < ./Formula/"$VERSION".rb | cut -d\" -f 2)
      checksum=$(curl -sSL "$url" | shasum -a 256 | cut -d' ' -f 1)
      sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
    fi
  fi
  check_version
}

check_version() {
  package="${VERSION//@/:}"
  new_version=$(grep -Eo "[0-9]+\.[0-9]+\.[0-9]+" Formula/"$VERSION".rb | head -n 1)
  existing_version=$(grep -Eo "[0-9]+\.[0-9]+\.[0-9]+" /tmp/"$VERSION".rb | head -n 1)
  if [ "$existing_version" != '' ]; then
    new_version=$(printf "%s\n%s" "$new_version" "$existing_version" | sort | tail -n 1)
  fi
  echo "existing label: $existing_version"
  echo "new label: $new_version"
  if ! [[ "$GITHUB_MESSAGE" = *--build-all* ]] && [ "$new_version" = "$existing_version" ] && ! [[ "$VERSION" =~ .*@8.1 ]]; then
    sudo cp /tmp/"$VERSION".rb Formula/"$VERSION".rb
  else
    unbottle
  fi
}

match_args() {
  IFS=' ' read -r -a args <<< "$GITHUB_MESSAGE"
  for arg in "${args[@]}"; do
    if [[ "$arg" =~ --build-only-"$EXTENSION"$ ]]; then
      fetch
      break
    fi
  done
}

if [[ "$GITHUB_MESSAGE" = *--skip-nightly* ]] && [[ "$VERSION" =~ .*@8.1 ]]; then
  exit 0
fi
if [[ "$GITHUB_MESSAGE" = *--build-only* ]]; then
  match_args
else
  fetch
fi
