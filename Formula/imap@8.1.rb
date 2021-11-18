# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8965d6b2abbf58b53af3fd4316cdf8f9db67f136.tar.gz?commit=8965d6b2abbf58b53af3fd4316cdf8f9db67f136"
  version "8.1.0"
  sha256 "fefc4b74d043cf31479be55309417c82790bcabdd255c7e4ad5d2ca0c9063bcb"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 36
    sha256 cellar: :any,                 arm64_big_sur: "f1382312ce7a707f7550d0a7ab4f1319a0d93956b2e5a182f0f07637ce210a69"
    sha256 cellar: :any,                 big_sur:       "06564f90cf406a3af2249992eeff0a8876753218fa37f1bd5855d4f136d0ee24"
    sha256 cellar: :any,                 catalina:      "7934c7771d4e389f6df2472db740ca641f1f2ed481451ff8d75f23b9f7f27347"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "362d7caadd41953d692e001a555630cc9fa43cdf672f371df1e4beeab60ef3fd"
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
