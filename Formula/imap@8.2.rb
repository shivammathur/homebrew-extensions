# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9a165336bd742b3414a165922764cd0e4e6498d3.tar.gz?commit=9a165336bd742b3414a165922764cd0e4e6498d3"
  version "8.2.0"
  sha256 "ae88b54259f920a744cf2b76498dc8aa2e2e28570b1e4842abc476ef2f6d6032"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 28
    sha256 cellar: :any,                 arm64_big_sur: "13a513704ae852ce9a600dcb506227db180924ce09caaf5a3ce615621045e4ac"
    sha256 cellar: :any,                 big_sur:       "48c0511ca1155647d784bd36bccea3e7a5eac7caf426df0b0fd3363b56a6443c"
    sha256 cellar: :any,                 catalina:      "b7faa8abb00011b73df7d86606d0f7e2ac627476650907eb256a9c1573fbeb02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c32ff64e05b7f6c455257a68e4c865f44e8637543944a7a378edfd284ddc034"
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
