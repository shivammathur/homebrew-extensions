# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1ca91c2bd84fd6596460eacd541c0867b523d73b.tar.gz"
  version "7.0.33"
  sha256 "f198b54226f4c3e0b24d8e4b50e748e1fdf92c41db3cb01c6ff3c2287ee61612"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "d0c7ce937cf8ebc9f78e0a51185173ca2d93f1081e5d8095007f9b25c65e24fd"
    sha256 cellar: :any,                 arm64_ventura:  "ff81689ee22ad29c6bec083621d73b9fe59666d9601dc3e4993ee73d9f88d535"
    sha256 cellar: :any,                 arm64_monterey: "5f4cf22f2a4816784dfba3bd611c97544f828e6614185f0625d558901c29e8ab"
    sha256 cellar: :any,                 ventura:        "ab614653e45dba9e1a64c3a15216600a1ce0d486324decf2de5dfe9c63b1ef64"
    sha256 cellar: :any,                 monterey:       "ac9943aff878132b3da9bc93929bdd28733a1113529e99e39b829f08bf78ec8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6383e8dbc1c674bc3199eb6f567ed1313d1c1559649fa44613ecd2f1de9b2777"
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
