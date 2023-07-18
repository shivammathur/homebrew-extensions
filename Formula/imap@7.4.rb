# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7424bc30ea6ee2385f843dfb23f843b551008d17.tar.gz"
  version "7.4.33"
  sha256 "71139f37f15b8172db13fbebda91829c305d506787e0defd090044ce92c0231e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "e9d122cf15d04660a771bce460de5ff89eb052a004232e851dbacc9ea2c8d632"
    sha256 cellar: :any,                 arm64_big_sur:  "c63b736b60b2d020bfce4cb27f3d895d71097fedde696f1de2a18656ea3987fa"
    sha256 cellar: :any,                 ventura:        "9e8327041424b8b52924f99cd5245962ce2dfb26016e585c64d2b7575945f6d7"
    sha256 cellar: :any,                 monterey:       "d23a11d209d333de9057627e72f122a35d4871f0db22226813f0388b623c8385"
    sha256 cellar: :any,                 big_sur:        "001ac9171504bf200e07396953b7993356ffa9fc4607d16a834f0c50f7e9aa38"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9501fdc0991a30136b2109f185723230c385215b04419f2605063aecd4f0ed2e"
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
