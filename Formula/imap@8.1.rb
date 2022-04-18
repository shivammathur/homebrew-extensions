# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.5.tar.xz"
  sha256 "7647734b4dcecd56b7e4bd0bc55e54322fa3518299abcdc68eb557a7464a2e8a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d0e8a6f0e493ab342cb18fb1b13dd3ee601d65642257868853d7ef487650626c"
    sha256 cellar: :any,                 arm64_big_sur:  "2bdcded17143e261a1aeb89f23a088de33bb5c7ddf776df7ad286deaa9c4c194"
    sha256 cellar: :any,                 monterey:       "933211233ea5174682a7a1f33fa33c4a2767cb0e3705eae7a8fb88ed4f185dca"
    sha256 cellar: :any,                 big_sur:        "3db75b200e195aa4b07d6e40bd81c7e806d4856ecc82d87c5c07858e0038ac73"
    sha256 cellar: :any,                 catalina:       "a00f457e95d5562d46c3277d2837a7b1c4b900d467a62b68eb3b02c36b1d0f3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c438ccffcfe7b7dc2a5e1c4230d87902c25e7a341106ef22845f25a7f9faa7c4"
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
