# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8d5953c002e9acccc373e96998ab62ab64990fa4.tar.gz?commit=8d5953c002e9acccc373e96998ab62ab64990fa4"
  version "8.3.0"
  sha256 "b533042c86b5dd07405b9a8728ba5bc8f8ccb57c9fd6425a31e8b06ad3cb4303"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_monterey: "1d62117c117ce26320fa2e7302c70f7c268c77d68a31a5ce5314dbb82c12ca21"
    sha256 cellar: :any,                 arm64_big_sur:  "61be450f0363956bbb6e865c2f1fcad0c1b2cc602a0d4aca3c8dd66bd620c684"
    sha256 cellar: :any,                 monterey:       "afd23977aea0a578cc487843fc175bfff4d8981b0faac3d14d1dfc8321b253e2"
    sha256 cellar: :any,                 big_sur:        "d76b15f8b34f04cb53ec2004f0168569203827f46419d2548964006e1a435f56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b4c10d5f34c48aa7709baf2d92ed9ea9df1c2455776bc05161527b01de9fe98"
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
