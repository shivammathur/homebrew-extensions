# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9717e9fd564deb5a99bf5602c4fd7386ffad45b5.tar.gz?commit=9717e9fd564deb5a99bf5602c4fd7386ffad45b5"
  version "8.3.0"
  sha256 "3e021ea7b341dda41b16f91de1d18d11fbccbceea854e77d2ad8c9f7ce4edf50"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_sonoma:   "c476e648ed04b5fa2db3eaec494bf495646be437cf1df639195266f0b171bd7b"
    sha256 cellar: :any,                 arm64_ventura:  "9c0d6d324598c5419cd9eb302f567693b7dbeab436fab0914d5ff4d01db1d5cb"
    sha256 cellar: :any,                 arm64_monterey: "37d91ac5ef35e788595b0cc248bf598b18042cfa5604175e86d94ca5b7e1f451"
    sha256 cellar: :any,                 ventura:        "64c3a6d760c30161e7e90601626d70fa7931c9b1f3b4e50705c3720d2a5aa690"
    sha256 cellar: :any,                 monterey:       "26eb348b0808260a674fb2912d9ae2ca56901216598c2e8658996cc22cac74f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1b54310e10c463adfb188dc09663c26b8e8502d740ef3db0acbeac635af8b906"
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
