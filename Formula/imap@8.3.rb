# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.11.tar.xz"
  sha256 "b862b098a08ab9bf4b36ed12c7d0d9f65353656b36fb0e3c5344093aceb35802"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "2ab4971de32be7d321ad301f09091ff468e48ff60600511ad7a0b7f41a17727d"
    sha256 cellar: :any,                 arm64_ventura:  "c5bee2b9b98ce5d2ee4901883262611ae29de64f354dfdb06e7794b953c175ce"
    sha256 cellar: :any,                 arm64_monterey: "3957c30b6a16a4ef4508dc349b0f5e8c3a38ce9af6507cd12df80ddab3a887a6"
    sha256 cellar: :any,                 ventura:        "b7a8ca0c7784947387fd60cf2c459a84afe0d7971a2d2afa53797d2a70e3294c"
    sha256 cellar: :any,                 monterey:       "1a4a6f19f9bce87722428cadf1eac471d6c043a2cd726ee4c0b1cf03840d134f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5a12dcbad1d61e5bbb5b514dd496b3d5ef833137998bdf205ab12f36ae4d3ac8"
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
