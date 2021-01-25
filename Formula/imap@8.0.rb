# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhp80Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.1.tar.xz"
  sha256 "208b3330af881b44a6a8c6858d569c72db78dab97810332978cc65206b0ec2dc"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 "37f16cee2c84d08fe192a19351494c436cf86c6e5d42735326e87911e7de79f0" => :big_sur
    sha256 "29084f71cd6373925090d9ff32248ac902cf2933e153cc74c62136674c610a02" => :arm64_big_sur
    sha256 "d9381e049ff4a02b4d6f25b62cbaa4c8bea0fae9f123a0f9fc0f80f558e636f8" => :catalina
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
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
