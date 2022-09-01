# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3db5fa40087cc418bafca1eeb920cdcf0e297566.tar.gz?commit=3db5fa40087cc418bafca1eeb920cdcf0e297566"
  version "8.2.0"
  sha256 "502b6b38382ca7f725aabac9cf64903fb565c0976ef8995b322b2eb459910c42"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "533fb0cc58024568d0d84e4269376c46cb8892ea0b52c9009b8d6686432842b6"
    sha256 cellar: :any,                 arm64_big_sur:  "a3a2f9300e9502c23abc69944ae4f9f7c1ce43df770f220073040ba13190d735"
    sha256 cellar: :any,                 monterey:       "e325587849e617664b0dd19c9a712e20940413e1add735ab75e109aa76b32379"
    sha256 cellar: :any,                 big_sur:        "ede549940b814ee15d20b69bc1e3c0ee62a8e18e4222c0ecbc60d197fcaf9661"
    sha256 cellar: :any,                 catalina:       "6a72ce4a1655609903c9047ce1b22b5f756d4cfeec55afe55b4b4b8d473b4f09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8a5fd54543a1e610049be00578cea6194a14c7314aad2bb9637050474684bd5a"
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
