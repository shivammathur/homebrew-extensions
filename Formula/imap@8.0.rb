# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1c9dd35b4ab8c7b42297c7950f9041c3ffd4d172.tar.gz"
  sha256 "c5c64d46f1d150d91bbcf8d36dfc5002c192f1984c42332a81fe10d0fcc52b90"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b0b83eecfc570661488d1d9441873fee34b254b8b07dfcb8c36a0e58a7966745"
    sha256 cellar: :any,                 arm64_ventura:  "e01c1e360dfe6b7d03bcb176af4c55a9d4107c7bc667bc00cbb9b9c907c65907"
    sha256 cellar: :any,                 arm64_monterey: "52d2699c2daa6fb207ae7d1c627dbb63c7ef7fe9915757c0ff7eafaefb0ee12e"
    sha256 cellar: :any,                 ventura:        "0477280f498df199bc9559d8da7efb1838d8e53c5a33c1b073ea7a1c4182b835"
    sha256 cellar: :any,                 monterey:       "63c058febd1acdbbda1260196363c38a3739f260e1ed657c5ab25dd39618a012"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "59671996f142c8c54a2e96f7b5690c027ea63006e0bf895aa2150a85cfd54cac"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
