# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f3d8f097201c4aa099cc256f4740ee845f4bd606.tar.gz?commit=f3d8f097201c4aa099cc256f4740ee845f4bd606"
  version "8.2.0"
  sha256 "9d1cd71a77e14ff2beb0089bc3b4b0d5d806b225de0bc15485b78a2fad5378e0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "4ae4f9ef94ac62f6a5dada3e696b30f08a76127d756711c7a58a43fb4c1aa1d9"
    sha256 cellar: :any,                 arm64_big_sur:  "c1461133977a5bae25971e9c994dafabc45109592656111fd1f1efa28b09fc4e"
    sha256 cellar: :any,                 monterey:       "86a729bf7079242ecf9c6475d7910961549094b6dde24b414b65f5c87c19890b"
    sha256 cellar: :any,                 big_sur:        "f315220f15f9d66476b893f00811d182fd741bba25a11efefa54dcb9bd38da8e"
    sha256 cellar: :any,                 catalina:       "3febd848e9529afd1b034934dfd587afae68fadc97d4897bd5c10b4da5b671a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "393adbcdd5c3c83d4a3a1fe3a1f576cdb46c89ae2640f420beb9ebb6f0652efe"
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
