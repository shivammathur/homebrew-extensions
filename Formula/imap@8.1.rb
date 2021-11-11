# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4aa73bbfc4cdcc4a2478a362196c66c85daca314.tar.gz?commit=4aa73bbfc4cdcc4a2478a362196c66c85daca314"
  version "8.1.0"
  sha256 "cc045522f5a335fc9eced87a8b6feb276830f106b4e305f92f32534cdec8da0f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 34
    sha256 cellar: :any,                 arm64_big_sur: "0b74abb4d2106058d1ae16126bcb9964a89c92c8c87a5d768a1303b1287d54b1"
    sha256 cellar: :any,                 big_sur:       "a557a08d07c612d2334e09acbf0409f3df2a879fd754c97f0e7cc3d74b89c48f"
    sha256 cellar: :any,                 catalina:      "dfbfe7e04240ee232ae2986c0845460072bb90e53e343f1028f5b76795a07384"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b05e8ad1564f6410c3cb5c6645185d759fad1c5f45aa25c59a4e253f497bd1c"
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
