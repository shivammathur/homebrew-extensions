# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.3.tar.xz"
  sha256 "b9b566686e351125d67568a33291650eb8dfa26614d205d70d82e6e92613d457"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "509dc8b2f780d5b280af8a7fd27682dd14e9f0dde23f7c71ebf82ba23ccf9261"
    sha256 cellar: :any,                 arm64_big_sur:  "da52fbfe51c1d6dab885668416530167e352903c39d36c25c47a5b76c3daa8a2"
    sha256 cellar: :any,                 monterey:       "728184251b0ca03a93cc28df8a8a9f8b6d804a23bab0deae2384bc9dce5f5957"
    sha256 cellar: :any,                 big_sur:        "c6d2bad5dbec607a26767e4231914a2ce300809bcf3ee1cee4a7e583c02dd0b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b5928e30d020fdf8d2986d3bfa1983da3212683a5f604e2c34b3e3d357eecbf"
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
