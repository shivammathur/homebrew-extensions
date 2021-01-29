# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1611894022"
  version "8.1.0"
  sha256 "a8fa39658471e91088265bd1f4e7af87203c3584ab84d58b909f0c9baad78cac"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 24
    sha256 big_sur: "ca139ae0b2ba5829d25a9facba9bc76d441e73e4d3742b6879a6ba5cecd95a0f"
    sha256 arm64_big_sur: "717594faa87076e575fb433baab3f91562dbe64729101ec7502230cbaf5ce85e"
    sha256 catalina: "3daf9828a44d191cb585a06566242edf43a0ae3a48a3d46786b93aaa57b6364a"
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
