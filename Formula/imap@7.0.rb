# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e74d83cb136282e1fda676bf22a7cc7f5578626b.tar.gz"
  version "7.0.33"
  sha256 "a40f969f584fb35b1caf1d2f5c45dfceee92f7e9d8e61b26b806f7537c5c645b"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "9fb7ca79db91938109626133959138c28758996da211bfa597c1664a46c9221f"
    sha256 cellar: :any,                 arm64_sonoma:   "3272a7f930697b394dfc0cabc3bfc911cc8a643be017defc9ac4cb09aaeb9213"
    sha256 cellar: :any,                 arm64_ventura:  "fbfce7bc0c7ad057dec855f53b7377dc944c469d6f15aaa281359373e8d20599"
    sha256 cellar: :any,                 arm64_monterey: "8a2e109528dfb403ddf9b280a882a8d5ebf05f40ee08e96f1ec28807fb1e9522"
    sha256 cellar: :any,                 ventura:        "ecd6f14772e7e2cbafce3db6a3927965566a55d1367603f787ad2ddd80c8aff9"
    sha256 cellar: :any,                 monterey:       "d9b96522fb049cd36efe52e90f2fac4c79ae40ccdc70162c3a4487795b99784d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6ba5529c6d16049da421b6ce01a3021cf69673c0c0ff11b41d3ff6cf1fa77c6"
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
