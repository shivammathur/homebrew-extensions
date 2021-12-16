# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/30a3280df73c0751cab8b342824b8d9a6ba91e3c.tar.gz?commit=30a3280df73c0751cab8b342824b8d9a6ba91e3c"
  version "8.2.0"
  sha256 "16ea933f847809097c8445131f8545e0b71ba987ba3db8c8fc27694c7261f17b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_big_sur: "69ef2cf9e0bd53a169c516fbb2c0f2275f7a164f603c5e6098e34c62a43cd5d8"
    sha256 cellar: :any,                 big_sur:       "5a516ebdeb8a22c4ee9d43cc2ffd095d79f91d38b486d492814553d971e15219"
    sha256 cellar: :any,                 catalina:      "29aead635a6f004621431b9779c5075c3ceb7c101045e86491761c0558b7fb2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f442a9d5ed8405a49c40891bce893676e47bacaac47da8fa3531ae36f538444"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
