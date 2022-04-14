# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/83610987046d5a5ffea2777853d4a4f2d3313387.tar.gz?commit=83610987046d5a5ffea2777853d4a4f2d3313387"
  version "8.2.0"
  sha256 "3a9721bd1181c67b7eaf8cb3ae4ad7adbbe98b862e2478216c2db200dc3f2049"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 45
    sha256 cellar: :any,                 arm64_big_sur: "5dbb0ffa406984240b088ddcb72a5169dbe34477c03a5414c56c3a6f08fb39a9"
    sha256 cellar: :any,                 big_sur:       "37b9f633ab1d61153566db29b4ad4e8f315e208d413a6dcbfc24eaf177d65d59"
    sha256 cellar: :any,                 catalina:      "2281402d93f8bf51b19ede7816572f110a189d64ca07cb798e7cea2a8606d8c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d6a8787577727f28b0462ad5aaee143ce4e4b4733c72a7f9f0afb663c9dd2a36"
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
