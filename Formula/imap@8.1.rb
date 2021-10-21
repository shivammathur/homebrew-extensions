# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/11dd5e6e0869354d34b513ccf5bee4759537a119.tar.gz?commit=11dd5e6e0869354d34b513ccf5bee4759537a119"
  version "8.1.0"
  sha256 "76342f0f28313e3711ca6cf868f9ded7a8b7914c7043ed227aae028b2b1dd483"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 31
    sha256 cellar: :any, arm64_big_sur: "a3dcbd01a75fa700e83f3ff31c385150e7d250b9dfb85568f75d4b33c9414ad6"
    sha256 cellar: :any, big_sur:       "01c9e2530b105c0d1188f45c7259ae0c5266ac2ad5450427c7fe0ecba577568f"
    sha256 cellar: :any, catalina:      "e643eb5ce39baf8fe5b02189f1f87c56ed66dfc933e78e1b58b788d2b91a275e"
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
