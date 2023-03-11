# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5c058d7b150fb5042681f43b27045bd752626047.tar.gz?commit=5c058d7b150fb5042681f43b27045bd752626047"
  version "8.3.0"
  sha256 "e29c5b00dbd6b70aa3c34abcb6aff93ac68e96be636b19d08c8164cbaa01ee29"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_monterey: "65ba11105f0a45dea402e74bcf6a0eb706f157341c5ab586ad4dcab8a505d7db"
    sha256 cellar: :any,                 arm64_big_sur:  "f59281c6776614c5839a5c4763417c43125af404cf5fac6fb84768b57baab1c1"
    sha256 cellar: :any,                 monterey:       "4b4ebb69bf7da156e20f3efdc4927b15f3d8294b3ad66895cc3ec4c1f3de77c8"
    sha256 cellar: :any,                 big_sur:        "117c9a8fd3f31b72b87897144dd0627faa4a8a6e919667106945d6c619e4b033"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ef49dcff4772f29b5d7f39981391d39f06a3b7bad3bc6490674490c8e950df0e"
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
