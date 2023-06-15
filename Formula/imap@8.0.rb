# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.29.tar.xz"
  sha256 "14db2fbf26c07d0eb2c9fab25dbde7e27726a3e88452cca671f0896bbb683ca9"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b2132727c36ff50b14aa2f91161551977163c696276a6f2d44651599e20b0a6a"
    sha256 cellar: :any,                 arm64_big_sur:  "643727e63fd0ff0c6da9be9d2a42e9ffedf5b97cd4641d7ac00518b8257244e2"
    sha256 cellar: :any,                 ventura:        "8fa116ce07563fa65acd1d014047427eaa1c1233bd715e68ddc95b2b685beaef"
    sha256 cellar: :any,                 monterey:       "a90fd06022cf8d2c99431192417b12250822ba59cf5b2af4ddec3f8a1987959b"
    sha256 cellar: :any,                 big_sur:        "8c504a49bd6c40fc73a764a95125fb122c1297b08565da6e951a9e6bd6441654"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "70b0531cce5007cad8819753cfef36987570fcb9112cddc64fd12ab4b3479dfc"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
