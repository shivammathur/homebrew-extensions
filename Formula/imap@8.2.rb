# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ac2d85da4dcd9616d08f33291a0cf7f6e4d1bc8d.tar.gz?commit=ac2d85da4dcd9616d08f33291a0cf7f6e4d1bc8d"
  version "8.2.0"
  sha256 "f4bb3bc315a4cc9e23cae89e09d083d0204cfcf216cc88192cef1583ed7bd316"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_big_sur: "475dcd48a9ef6dc77659af0022b0dfe4029c00a0db0fd594e20f79482401e27e"
    sha256 cellar: :any, big_sur:       "c36f75970291fbb7c586f882067de3eaa96ce016f605b7885e6697914594c6db"
    sha256 cellar: :any, catalina:      "ccf546ba8e53d26bcba73eb52c69cbc6c516345fae442b38003d8c7ad796dfec"
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
