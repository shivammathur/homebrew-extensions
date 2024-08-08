# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0788496bca56ea3a6ad75758aeaa38f81267415a.tar.gz"
  version "7.0.33"
  sha256 "6b59873eef34f7205e20683a0e6ad99509a1c158e619ff52ae6269d64d49f5e9"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "21a4ddb2ae450278983b085f16a9e1ee748fb732e32b6a367e0d1bc699086e74"
    sha256 cellar: :any,                 arm64_ventura:  "13e832af6a0a201e849fe11be2b0dbfb83ffbd416e29779096b0d7dd4b9196b7"
    sha256 cellar: :any,                 arm64_monterey: "ddc832f4637af7055a2425d90e69ab515cdda25d03a1c56c49e14427e93a643d"
    sha256 cellar: :any,                 ventura:        "d7bca8ce8c8cfcec0c5e6ec55ddc58bc5c11038320c14e36d210fe5a6a7d8956"
    sha256 cellar: :any,                 monterey:       "44d021300522d381f4f3dcd207b331787d172d5612cd466859e19076171b3fdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "58475c22a6cfa04cfe02b04e802abd12213612ce4e97f5f6523355bfb10dc129"
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
