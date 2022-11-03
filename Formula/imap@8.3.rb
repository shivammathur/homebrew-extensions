# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ef5ed06d3cc615ad3ae5c7b7d601ab9e4a35111e.tar.gz?commit=ef5ed06d3cc615ad3ae5c7b7d601ab9e4a35111e"
  version "8.3.0"
  sha256 "a6c49347aba53ef64975cc4580bbf4f97698c5e5836f821721a67794a6e0c787"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "350b57947b3371dbef5cf165cd1ac9504855fb80848bf00d24865eef0e406fd1"
    sha256 cellar: :any,                 arm64_big_sur:  "726d5370f1f4c802e412dc125c6d6b40672286c98bac50c9f18b3382892052b4"
    sha256 cellar: :any,                 monterey:       "4bcd8c74735da44ded155d52135994569d1be0fa9379a9794643c14379c56384"
    sha256 cellar: :any,                 big_sur:        "b624d99aacf060f790063386c0d3c323b43c57384f2b8da0dc220494a13c105a"
    sha256 cellar: :any,                 catalina:       "b1cb577a42c8e26c7545905a17385e6c535a2f77022d63cbf93e024092f108c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b88876aba56ecad5f10113c9c844d1d9f73d4821da8f51b158ee6f3e35578542"
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
