# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/23b94cb5a79daa7a6c3976d65f447c4a03415f64.tar.gz?commit=23b94cb5a79daa7a6c3976d65f447c4a03415f64"
  version "8.4.0"
  sha256 "1f11176f6152a367a10b4c3f2e47005c551148c12793b00e6232a4d449559e71"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_sonoma:   "849892bf4862441a14f29a886526f30b400d9b415d311174c265c87b235e1688"
    sha256 cellar: :any,                 arm64_ventura:  "0952feb866a769c9e53c093d382c3a14c29608ae3ceb8a6b2b8d8a33a20fb7d3"
    sha256 cellar: :any,                 arm64_monterey: "88602d30c4a67dfc8baaeade179609029a5cbd1a6f6fa6bf309a495ea9dd100d"
    sha256 cellar: :any,                 ventura:        "00bd15a4b44120c85570cbf6149bd79c8393864023ff240899b38fe22d9c4599"
    sha256 cellar: :any,                 monterey:       "1e79714963e79085fc7c4fc280a8d3a4c403f0e9cd54d0196d82d258dae729d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9f4073b9a497567ef5f0ed67099584a6f654d6e6bad7e597c25051d6f9132c0b"
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
