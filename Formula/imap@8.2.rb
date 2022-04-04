# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2874e5fa052d54affd31ed5eaf3e0d53c9116c93.tar.gz?commit=2874e5fa052d54affd31ed5eaf3e0d53c9116c93"
  version "8.2.0"
  sha256 "955b8ab936105484edc1cd4ef10c3b25a62634708ff30db4afcaf5a9393e16c5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 43
    sha256 cellar: :any,                 arm64_big_sur: "417d3d0a6278c5a778054580fc0dca555b2c336636f4af26581f7c128da66018"
    sha256 cellar: :any,                 big_sur:       "5876b62ca964cc677b70b036ae137119b1ac6e60d801410edd19477e00d53f3c"
    sha256 cellar: :any,                 catalina:      "1eabc63cca85e5efa1a07043ea28de9afb12a343e9609b39de0cff3736d25fa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f8e2c0302556110172261bd34648462a3c214d8b903bebba61156124b2b89884"
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
