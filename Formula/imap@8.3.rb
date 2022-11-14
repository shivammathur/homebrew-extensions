# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7666bc52267c9024d28a064d84199960779c7080.tar.gz?commit=7666bc52267c9024d28a064d84199960779c7080"
  version "8.3.0"
  sha256 "4763718bd8c1ba758eb532be28b383cd9bd1cf2038ac886d839bf2c9b1d19b28"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "1742240446b24ba031f33e38ba03b7c0ef455fd9278703fa1406547eeb32b77a"
    sha256 cellar: :any,                 arm64_big_sur:  "a44261bdb262168cd24343b6504ee3c8b6033bc4b6e4a0fab820b48a0312abbb"
    sha256 cellar: :any,                 monterey:       "d9dfc2b001981e582c80294f9523ab885a7eb1c83b08a6dc30dd31e4a6b6c76d"
    sha256 cellar: :any,                 big_sur:        "97fe454a5ab199b8dcaceeca198373cf945e1e7ba8adaf5c0a3238cd8a9975c9"
    sha256 cellar: :any,                 catalina:       "588e7c695fd898dcf1356a53eb749dfe8010b418d77e7648ae4b432aba16c719"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6db8ea5b23512efbb05a5b6dc6b103a5aa06b726b5bb48da762ad9691b9626ac"
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
