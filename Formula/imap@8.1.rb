# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4317da35d36150d2b876861ae48038477dfebe70.tar.gz?commit=4317da35d36150d2b876861ae48038477dfebe70"
  version "8.1.0"
  sha256 "15faa2d4dcb3a3ee6605d2ddff6beecb63e0c86de10e9e90aa41588c42be363f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any, arm64_big_sur: "9185107f1c1a3ba2924fe0543dbb747f58f69eace09780258bdeb529536a59ea"
    sha256 cellar: :any, big_sur:       "bab7810743f2850c6614e934430d5e4fa5dd2d247e62138c389588c8a1b2cce2"
    sha256 cellar: :any, catalina:      "eb1aa5fe54c78f519a2484688a72ca510c076c4c9abe22237ed012d8a9fcd6ff"
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
