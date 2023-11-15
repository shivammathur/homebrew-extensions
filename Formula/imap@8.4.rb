# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2ca142ecd8e3af5a2ac09938546b57123d01297d.tar.gz?commit=2ca142ecd8e3af5a2ac09938546b57123d01297d"
  version "8.4.0"
  sha256 "1171610b5b4398a7a2cc5ef9da33d17a2c0dc1ddb542b981d443f37deb05786d"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sonoma:   "594762d48ef9a2d8f297a92288c02a3d4cf444cdec9811479397e717453845ee"
    sha256 cellar: :any,                 arm64_ventura:  "f0a020a59881cd82cdfc12a498dfc1d205bb4db510f6b63fedf8d2c95acd7485"
    sha256 cellar: :any,                 arm64_monterey: "236b9b151e5ca89d31740cd1e098512baebd2afba736f38f6fb07ad32896e07c"
    sha256 cellar: :any,                 ventura:        "0464b2dcc74ad5921a5b0f2f21e80dba6ff609025dae1f97ce4a94814294c3ae"
    sha256 cellar: :any,                 monterey:       "f2fa7ed33af3901e2967c264509a6ff1a4ce46e4ab0ed1e06ae8a042013b1c05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5c306f1bb21e1f44836e91a549b4917a1e2760bbc399c36d556d91d61703b3e9"
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
