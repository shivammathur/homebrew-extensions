# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/cddb65b54e9ca0d4869c4503113c9b7aa9bd2980.tar.gz?commit=cddb65b54e9ca0d4869c4503113c9b7aa9bd2980"
  version "8.2.0"
  sha256 "9cb05b6f7933e507065c63869f28f14d817a02134db13d1b398ce39c08ba0fe5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_big_sur: "09e7012d0a062c859729f0bbd69a5b396a33134305b0a3a913cf87a8b6cdadac"
    sha256 cellar: :any,                 big_sur:       "5908755f95e08e832bfeb906f5fad27def2b56838b4726a3689420622c36aa3d"
    sha256 cellar: :any,                 catalina:      "c3e6101b9e9bb5a4fa55599d14ee4db4e6c6fb9815de8d5d8ddaa1159a070f13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31f788630483f6cd4f5440bdc96489a757ec4b315041749cd51b9f9dd3398563"
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
