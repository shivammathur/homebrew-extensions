# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1613621625"
  version "8.1.0"
  sha256 "8ca84161246c81d360c16d4d67e27a830c4b66d25fd5bc894a074ad5d60ab63a"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 26
    sha256 arm64_big_sur: "c9957472cde2675e660da6e50511002b384410a127a8bf226012c62a8d8cb826"
    sha256 big_sur:       "0d34a49dd67ef32e848ab8a892ec55f1316baf1ad8c429b806cbf7b418f12d2b"
    sha256 catalina:      "fac59667bf618fa374ce55dc92b660e0af69fe5e5e7a2df70badfd47fb73bcc1"
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
