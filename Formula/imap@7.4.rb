# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.29.tar.xz"
  sha256 "7d0f07869f33311ff3fe1138dc0d6c0d673c37fcb737eaed2c6c10a949f1aed6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a9d013059228f08f20d07ab379c1b2082e67ce988ee78a6bdfc45b92a3cd764f"
    sha256 cellar: :any,                 arm64_big_sur:  "602fe75eadb2aa6ab054aad94dd648cf2a1ccb35f6cad2e7d1ac715a52438a0d"
    sha256 cellar: :any,                 monterey:       "33cc62fff43fc99b47cb146b1291cb409b289edaaaf2d7aa64670c637fb3e2b9"
    sha256 cellar: :any,                 big_sur:        "f8443aecd10957a3a1f02e94f8b53d485738770647b82329594c4f96936a7490"
    sha256 cellar: :any,                 catalina:       "6af57c90c19d87f3f8c7349babc508a4107f275ea62de15671d845dbedb6ad00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "345a4adce31c94d9fa5bbf54b9882a623ba295b050cf0a1a23f1f9f768e53ce5"
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
