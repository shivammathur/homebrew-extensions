# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url ""
  version "8.3.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8301aaffedf6b2ebe62b8985dbb9be7926e56ac22c852b1d34a54ae816f0a076"
    sha256 cellar: :any,                 arm64_big_sur:  "645003edff9499deda10e1e27b516b62b46035cf84d5c78888cd655b0c4dcd10"
    sha256 cellar: :any,                 monterey:       "dca0fe89e11a6c41897959729a1bc714775065bb51b1b004e7c8e21a9045476d"
    sha256 cellar: :any,                 big_sur:        "3954e0f9e32bad06bb424e8bb718feab3bbab90f628ccd8ee8e11816778677d7"
    sha256 cellar: :any,                 catalina:       "0e02fb3df3a479407d41d21be31d92de49c8ca4aa86f52d0a5102235c443e845"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8c721bea8a1f40a37319fe59bed4645c3f617e60f003b57be7eff146a682ac8e"
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
