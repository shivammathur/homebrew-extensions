# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/184152acf9810b92f4b0042c291a9701183ba412.tar.gz"
  version "7.1.33"
  sha256 "38b1bf128e03da65f3b61266d3e674ab941d4d4fb215a5ecc7cf114eea478900"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "cd5df879b3eec79a49612219fc31069e490a6bc40c04b5034cfcef06024b34de"
    sha256 cellar: :any,                 arm64_ventura:  "0d5f45f7ceb8cdf1587962da16de5bf5ed7b473b8364088791f2d21324756fb4"
    sha256 cellar: :any,                 arm64_monterey: "64082762d45625f2593765eb3937b1804e51dda26f01ec13e1a2d5fd1f47f30e"
    sha256 cellar: :any,                 ventura:        "a8cfb094d3a0a2b69e51a9e2044ba233478ab20ec7bbd92f9d2235ab85c1c0b2"
    sha256 cellar: :any,                 monterey:       "efc54739cde16f59dc745989e6efebec04f24416eaf5705feb604825c784f05e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "223ded3031d33bccde6cdd268c428d5513dd3fa26f3dba6b2e0e4a6e4208c719"
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
