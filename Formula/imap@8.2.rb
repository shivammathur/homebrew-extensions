# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7e860eaef01a8ae5009bc0ed046e4eb1032411fb.tar.gz?commit=7e860eaef01a8ae5009bc0ed046e4eb1032411fb"
  version "8.2.0"
  sha256 "ee239c5463111497f0cc30dc2a3447c58a3b2c93a6a29dfcc34defe5e826d52f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 72
    sha256 cellar: :any,                 arm64_monterey: "92b879742294d5a71b149e4aa6efc6432e02c1c53532f899a11df191e511482e"
    sha256 cellar: :any,                 arm64_big_sur:  "5db51dce0e122e1158d989e190f68afe0cb9ec3931e4774f1549077d906cc52c"
    sha256 cellar: :any,                 monterey:       "6ee2a13e8126739abd5176a4eaac106805a947970c2dc3e0ad186a184897a311"
    sha256 cellar: :any,                 big_sur:        "df3824b2ef885587d77be640a2fb5af4202c46eea5a2154d00a602262c5767c2"
    sha256 cellar: :any,                 catalina:       "6c40f0b4552e1d337a80c6181171928db109f8cb4f1d3b29caf8ae11c36ed1c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9044a455a6de2a3e0f8cbec274c2a7f0e07edd5cb6d3f6ddff957b9f13f3217c"
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
