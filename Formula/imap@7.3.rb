# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c05cab383299e9511ac8f198c7a6cac6ab83fa47.tar.gz"
  version "7.3.33"
  sha256 "c8e863df3175b4c3cce46e2e99203b242fcd61a6f6b2749e77f92b9766aa5a0e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "dd6d21f8df78bf79d3c36eb9de0452e90f0ee4ee5fdf3e30e6ecc8a2f9c4addc"
    sha256 cellar: :any,                 arm64_ventura:  "13bd5671ce4a0f3e346b4e57887e4c5d5a02d03eaf0945cd054aea6099d3dd1a"
    sha256 cellar: :any,                 arm64_monterey: "157c4bfb18ae11182595880f7743a9180b087bd24e67b3bf3612e3d870ef14b4"
    sha256 cellar: :any,                 ventura:        "ea3222b986db478e85c513bacce7e51edbc62bb60d3a16a2f633d827c3135f97"
    sha256 cellar: :any,                 monterey:       "9baa59cc83fd954a041419266bd7b51309d9bb00d981ec501a5b5dfe66b77f9d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "25d33c0a534872c15d2cf88157cb2cb9a63f12a4586057abaffe1714e631c002"
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
