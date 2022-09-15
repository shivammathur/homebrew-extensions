# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/743d3780c6546062754887f9cb1706f87e71504f.tar.gz?commit=743d3780c6546062754887f9cb1706f87e71504f"
  version "8.2.0"
  sha256 "339ff578f7ad0c810f00c7e074f57524d058c0b4f69f563045a59e54ddd58066"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "8e2e62af3348f2efe52fbc33612777ceb4b0747935daa39c978ef827548dd48a"
    sha256 cellar: :any,                 arm64_big_sur:  "74d798a61e26e9d2dd5ba376fc74e308752c5e9d498a36aa788613ee56ed1903"
    sha256 cellar: :any,                 monterey:       "25b641b8f6848d9e01937c2fbbb893d2f8155fb7c7ebba360111c6ba376898c0"
    sha256 cellar: :any,                 big_sur:        "2e0178cba7d47eb9956c68045b0fcf17c58d5798ea81b98c57e5220d8e8a6ef1"
    sha256 cellar: :any,                 catalina:       "98989a177f78ddb9692009900df8b7003d598288fe06ca9ccb7bee673846ecd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7f1ab7d5a3a86793d3f177b7c55ac6e6bfdd9979b07994a26f717f764542f4ee"
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
