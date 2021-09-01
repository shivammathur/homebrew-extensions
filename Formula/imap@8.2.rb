# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a93e12f8a6dfc23e334339317c97aa35356db821.tar.gz?commit=a93e12f8a6dfc23e334339317c97aa35356db821"
  version "8.1.0"
  sha256 "8665f912f8c86af2c688ae2207ff23ec6e453e40dbb7d92e7b54fc7b81c31533"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "7c8dd5050260dbfbb9d0b89ee764aeae36963120711beadb1a6d65aaf2a9d757"
    sha256 cellar: :any, big_sur:       "85e0e778282b3adad4f0149be0ac60c32f137e12cf89a9d236ed767a672d5be3"
    sha256 cellar: :any, catalina:      "5c42e392377ca82e3a84aefe24799f2909191ccec0885238edd4b7c7239cbddf"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
