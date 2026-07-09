# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/64ca21fc4a956b8d2c151943dc22dbedb889f01d.tar.gz"
  version "7.3.33"
  sha256 "ffe700b4ddaf86b580bd5176bdbd2bfae785b9eb6786dde06afe6ce77e665ca7"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.3-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any, arm64_sequoia: "14fb5a34cd4b3a941e201afeac6c5a72f2e4f40cfdf11165bf49f3c04758a833"
    sha256 cellar: :any, arm64_sonoma:  "bde73ecf357a70643c2e87142079f174b6cabe662ca973d0720b4e76a5a8a471"
    sha256 cellar: :any, sonoma:        "1c389ff6bbc1fef715cb6c2342bc2db5386dfd5f5a04e1523267b1dcc10e109c"
    sha256 cellar: :any, arm64_linux:   "2f736688281f16eece5149cdb7b35ef63e60cb5b512ea8f2af3544c34457ff59"
    sha256 cellar: :any, x86_64_linux:  "fd128d0bf59d750fbc5d7b4f2661a82f1139f8d6d40bff22fcc685794c678007"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
