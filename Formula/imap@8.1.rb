# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a2bc57e0e531367f40fc50aa935bffac60cd61e8.tar.gz?commit=a2bc57e0e531367f40fc50aa935bffac60cd61e8"
  version "8.1.0"
  sha256 "4410bae79c0505999af08eb79e2701955280f51bd8ec1bf242880d5bbad58a80"
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
