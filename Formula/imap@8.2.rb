# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/529f9f89972c661fb28270aceef4aef47fa6a6eb.tar.gz?commit=529f9f89972c661fb28270aceef4aef47fa6a6eb"
  version "8.2.0"
  sha256 "d8ba1e951b06ac6c547039cc85e8710c0a20a29b2f55f3ec880cf11d9e4e7467"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 36
    sha256 cellar: :any,                 arm64_big_sur: "0d4f64ad9f27b15576e7faf97d9b5a5036b3e02c44da5fffcb584617688cd4cc"
    sha256 cellar: :any,                 big_sur:       "82cdb3a0c4457084513e3fa8e96e4a20c1965c1e88069ad184283086ce884daa"
    sha256 cellar: :any,                 catalina:      "6eb6969245f3637db6cdda68ada57b074975783fba95506dc24cc4de35325fc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "757c46b2012626d7bb0fab6708f68b3640aa5f7ad317ded646be5d21882be11b"
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
