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
    rebuild 35
    sha256 cellar: :any,                 arm64_big_sur: "95b9b8c7f5504070aed39003b5ce13f6f400b8bd8363abe347c7269707c3f82c"
    sha256 cellar: :any,                 big_sur:       "7de35cc386bba62623bb438b59a22331c9d99472d50499c874ea39d704dc80c1"
    sha256 cellar: :any,                 catalina:      "87348cfb77f2429199d92393419ce66059686a043e078a496693bff8e0c5fe0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f515c79d7f96f9662979247f1cfc9f0fa8dde43f0577f877ba7c379c7d51bd26"
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
