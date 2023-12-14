# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/be46545ee03261d90b3df644dade64b9ed01d21b.tar.gz?commit=be46545ee03261d90b3df644dade64b9ed01d21b"
  version "8.4.0"
  sha256 "43450b6f800048336f37e17304d0c4370640affc8e3f2631352834bebd4ed6a9"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sonoma:   "924f5124dd9b3f870cf326539ca110a3d083be6282cb7ad3eee7321285ad06cb"
    sha256 cellar: :any,                 arm64_ventura:  "ab762bbbb733a942cfb0d5392381a5425429215263dd1d33448299b56f607ad2"
    sha256 cellar: :any,                 arm64_monterey: "78787d94260a664a598826f1e6d3a408cfd170f6f0c57f5c9dd7d6a6106714a3"
    sha256 cellar: :any,                 ventura:        "c117313c76c1d475d030b5dacbf93bb9a7a7184a607f946d92dc746f29b6e2ea"
    sha256 cellar: :any,                 monterey:       "7eff50e95684aa5c73ee0af7b4c5fc3a2fb4bec53a358322e9e20b5251f295b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a958bfcc64883e25f57ea4494e8596c787e2ee4571af114dfa1956b1e56ebb77"
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
