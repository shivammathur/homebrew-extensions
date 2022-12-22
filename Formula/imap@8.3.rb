# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c46a0ce1981981694fb874ccd839806f5b5dfe78.tar.gz?commit=c46a0ce1981981694fb874ccd839806f5b5dfe78"
  version "8.3.0"
  sha256 "39aa40a29e5380a480711728132ffd978a6a56fdadc6bfa31e9603af9bdf984d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_monterey: "9763e26e85d03e1dc0b0a7b3870c8a888508c3ab3669c3837a5b835adedac313"
    sha256 cellar: :any,                 arm64_big_sur:  "ecdff94d62c00860a7bf9634a5ea5008600065c03398540047a7d736e76a3a80"
    sha256 cellar: :any,                 monterey:       "7a1cdf29ee834474e5c2dfebcc9f6f366c98e82382099b236347db5c6f15c320"
    sha256 cellar: :any,                 big_sur:        "7a76124c4c4c637fbc4b15bc1659dcaafb9a5227da6279d3244e8483a9f805e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6eb3b13d83d4946fb584c3d13fd1db57f975b40bafc958558152387db8d7c205"
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
