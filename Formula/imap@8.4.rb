# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1e7c64bd4dc65e3361e3b86d90aac1b116d25f69.tar.gz?commit=1e7c64bd4dc65e3361e3b86d90aac1b116d25f69"
  version "8.4.0"
  sha256 "80067f8a333ae63d5104d76f8a328e994c851e639d17619b9322eb9ac0790afe"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_sonoma:   "01bb17e459cb2af17f8212d4d9071fba6fcbd6c757db21e202f46499871ee10b"
    sha256 cellar: :any,                 arm64_ventura:  "548e09a65f86d8482e08acdffdec8cf120d67f95150019091f276eaf987fc418"
    sha256 cellar: :any,                 arm64_monterey: "2845ce44d4cc51f463a32569880e5b08cc6dc9e9f490078e94666841b7485415"
    sha256 cellar: :any,                 ventura:        "6b639a229eaaa673fff3266524a8582aa690087f34ba34234edf9bf4096af96b"
    sha256 cellar: :any,                 monterey:       "3a80be99664f556cdc683428f7ee1b9fb9cd3787e0cce7601d654a10e31ddc39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2c672630f385eeda7c30cac92cfa2521c107a61c024156e1d1d47f75ebdc17a1"
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
