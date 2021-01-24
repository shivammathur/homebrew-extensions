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
    sha256 "dc98d0fdf25941d6ff18561bf0df7f1b4e5f61943709eb787b0ab6931b10cf39" => :big_sur
    sha256 "1a908dfd69d2a6f46635f32bb51a83f051d61f3e63899ffeaf057621db33a860" => :arm64_big_sur
    sha256 "bac49d716bf356780891b08cc09aa1f97f2078e4a4100aad638374fcb673426d" => :catalina
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
    prefix.install "modules/imap.so"
    write_config_file
  end
end
