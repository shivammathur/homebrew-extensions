# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1614832876"
  version "8.1.0"
  sha256 "cbe8d1bd4fe349d097c2ca29a9fde34658d889832aa20498c684b514c200ebc0"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 28
    sha256 arm64_big_sur: "5a300817ffdb900ec64f239a517300ae86c5fc624175659f4406c8deee19679b"
    sha256 big_sur:       "a799419b947db1bf2ee00809c62bfadd02568a072501ea7ecce364b21fdab33b"
    sha256 catalina:      "c70c188bca97100b3e8385c5150202e9394cfdb8a441b0ae2cfea5918f45c03c"
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
