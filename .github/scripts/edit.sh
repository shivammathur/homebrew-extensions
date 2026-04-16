needs_commit_update() {
  case "$VERSION" in
    imap@5.6|imap@7.[0-4]|imap@8.0|\
    interbase@5.6|interbase@7.[0-2]|\
    mcrypt@5.6|mcrypt@7.[0-1]|\
    pdo_firebird@5.6|pdo_firebird@7.[0-4]|pdo_firebird@8.0|pdo_firebird@8.6|\
    scalar_objects@7.[0-4]|scalar_objects@8.[0-6]|\
    snmp@5.6|snmp@7.[0-4]|snmp@8.0|\
    v8js@7.[0-4]|v8js@8.[0-6]|\
    xdebug@8.6|\
    zmq@5.6|zmq@7.[0-4]|zmq@8.[0-6])
      return 0
      ;;
  esac

  return 1
}

fetch() {
  REPO="$(grep '^  homepage' < ./Formula/"$VERSION".rb | cut -d\" -f 2)"
  sudo cp "Formula/$VERSION.rb" "/tmp/$VERSION.rb"
  if needs_commit_update; then
    sudo chmod a+x .github/scripts/update.sh && bash .github/scripts/update.sh "$EXTENSION" "$VERSION" "$REPO"
    url=$(grep '^  url' < ./Formula/"$VERSION".rb | cut -d\" -f 2)
    checksum=$(curl -sSL "$url" | shasum -a 256 | cut -d' ' -f 1)
    sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
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
  if [[ "$GITHUB_MESSAGE" =~ .*--init.* ]]; then
    sed -Ei 's/\?init=true//' ./Formula/"$VERSION".rb || true
  elif [[ "$GITHUB_MESSAGE" =~ .*--rebuild.* ]]; then
    sed -Ei '/  revision.*/d' ./Formula/"$VERSION".rb || true
  elif [[ -z "$new_url" ]] || [[ "$new_url" = "$old_url" && "$new_checksum" = "$old_checksum" ]]; then
    sudo cp /tmp/"$VERSION".rb Formula/"$VERSION".rb
  fi
}

fetch
check_changes
