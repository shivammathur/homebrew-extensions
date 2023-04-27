# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7b4b40f06f39f1dc05fc4be8531fa3d582062488.tar.gz?commit=7b4b40f06f39f1dc05fc4be8531fa3d582062488"
  version "8.3.0"
  sha256 "780d0f93a5e2308ee3ae6a16a07773958678cccd71fd4ff0d2ce31c53178a4eb"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 30
    sha256 cellar: :any,                 arm64_monterey: "1dcf5426872617beca336dc929d36e88235463d5caf0dd7840cf30b558f9230f"
    sha256 cellar: :any,                 arm64_big_sur:  "1bafa1218810fc753df9edaeddd0efabd698afecfd25dc65b36ecc694972efae"
    sha256 cellar: :any,                 ventura:        "3ebd5ae1ce3876ed7c4360f5dfc004d9755191ed9ab3efad0eec9e519887a683"
    sha256 cellar: :any,                 monterey:       "6582ecc4addd72f3fa96af6d770b3be30ff26ff04b7005b45bc97f0631742175"
    sha256 cellar: :any,                 big_sur:        "119a5bab1d58976a6d0b825722c6fbac7355875f4182f1de6f11519df647d1c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8482a862faf08d0390d74725a6a6ad1d603094c32ea12d124deabc0c269bcd00"
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
