# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f77964ef49a459f67561517cd77292ec505a03f7.tar.gz"
  version "7.1.33"
  sha256 "f4e0826d2fe16ae4dc9d6b7b54a0c24488fb1b66c8202f8a0c27987a9172ec61"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "f8cbf549073af37a1cccfd80c67e80d741d256e713e99c573618352f0bc4b57e"
    sha256 cellar: :any,                 arm64_ventura:  "a7557706e21369185a5cb14be0b80fead718a39b83d6788603a875f056afd6a8"
    sha256 cellar: :any,                 arm64_monterey: "40f48b1a18f7d7b6c1dc70c69ff35390b57313c944d465c71e32ac919e1e9421"
    sha256 cellar: :any,                 ventura:        "14544b152a46f096f611e3cf92b547753221561798c8fa8ae6ffbfd871178717"
    sha256 cellar: :any,                 monterey:       "1c52a4ae9ef532476fd8a3aef1527d81277cc9321500fa9ba70e9598a3a9bbd4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4eddb3f45b17be7e8da2dd930380a93b133ef9e68519eb05232256b1b16cbf8f"
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
