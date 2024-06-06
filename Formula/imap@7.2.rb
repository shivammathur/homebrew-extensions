# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9f2f43297dcec5d2f679c2cf336a79bdb816a330.tar.gz"
  version "7.2.34"
  sha256 "4b1d6df7b8ca1b1e1a9bb78e964609728ff772f3620f9c5a479be02b3ff80b47"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "713a276b30c94ceaf492959bf591faca235dcbfaac083e02ce28faf6fd22c589"
    sha256 cellar: :any,                 arm64_ventura:  "41e742f6990ab0ab89a4eeb29df7fb34e19c36880ad77cf1ed0af7bdb3d67493"
    sha256 cellar: :any,                 arm64_monterey: "b7cbbeead6c5f0b9c8ac72a6eac2a0a80f93ae7889b34f77d1e48893e5539b91"
    sha256 cellar: :any,                 ventura:        "a6ed1f65d5322bd365bc1af3b5812bcd7f52e7c6ece89a3d3aafcb1ee3cc87c9"
    sha256 cellar: :any,                 monterey:       "cbd0248d8fbe9d598824b923564bbb7974e6653c9adb3eb331f90948049cb00f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e980cf50ae31322c3e5923ae74e643987e1276d9454921115b919f58cbb559b9"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
