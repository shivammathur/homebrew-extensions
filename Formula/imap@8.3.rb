# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/428043105087da4d69d9ab8668d7448d5030c989.tar.gz?commit=428043105087da4d69d9ab8668d7448d5030c989"
  version "8.3.0"
  sha256 "f54e265f365f912cf9c2a06f07985a429b3edf9ab9b58b6f358ecca0bc573a13"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_monterey: "06409f6d23e46691f884d0c30e071e8635d4e006cdfb08c483c2f1525c92bdc0"
    sha256 cellar: :any,                 arm64_big_sur:  "b4c4816506ded707d07cdbab5cb989adcda11f7d18f32fde8f04175e1406a5db"
    sha256 cellar: :any,                 monterey:       "8ff34d0f027a13f21a830840c4ac53fdc13c24bfb3e2a2ab1e3571d33c94cb7f"
    sha256 cellar: :any,                 big_sur:        "db133e6888190f9d80d022e810a86331b7fccdfd1b9e2e995334c7bc335007ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3c6fa159b47014ecddd4d5e7d909eade302c41db43fe043752714716ebe2ab6a"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
