# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhp72Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.2.34.tar.xz"
  sha256 "409e11bc6a2c18707dfc44bc61c820ddfd81e17481470f3405ee7822d8379903"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 "45228067734f63a8d27dd99f96d3f0fd5f190be00bf2bd11b4bedd48d26cda24" => :big_sur
    sha256 "b4420e5764679b18fe46e7a99c6db667fede559218130b898e8cbfc07d1e8467" => :arm64_big_sur
    sha256 "38391d5298159e2844c39f7541a94396fc1e89bbfcaadf573eff32344511d6b3" => :catalina
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
