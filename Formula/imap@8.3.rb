# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6a2b8851556071a5cefa1297e1a88bebc4753081.tar.gz?commit=6a2b8851556071a5cefa1297e1a88bebc4753081"
  version "8.3.0"
  sha256 "ed39bef1ddcd0bebf36924ed69a01d062f5b915346f9e06258c97fb82c257c5d"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_ventura:  "caea3ce7f0768ae04dd75c50a7d8b3e9d46749b083ae1a568f4a56e410cfd3d8"
    sha256 cellar: :any,                 arm64_monterey: "135f973aae2ecc07e7c55df50d294d0fb34986444663c2c287cc48ef0aec6ec3"
    sha256 cellar: :any,                 ventura:        "15cf023483055c693ce02ee94d5163e421bb2acd855bca9425c1b99628b84b47"
    sha256 cellar: :any,                 monterey:       "4e18500ff212f2ae0e9a63f98b897c08f1d6341fdf61a08b68993f1ba0f3b8e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "631d94e6e37599c408a9b9c144d21a213d55d10004e7772e6503e5983c3d7af8"
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
