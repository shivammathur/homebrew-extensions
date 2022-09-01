# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f7d426cca697ed1e064ed7f8f5cd2a0b176aef6c.tar.gz?commit=f7d426cca697ed1e064ed7f8f5cd2a0b176aef6c"
  version "8.2.0"
  sha256 "49010a5a6fc19831190f6b5d02a0616dfd6eb6316e14bb43cc523acb2740d2ba"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 71
    sha256 cellar: :any,                 arm64_monterey: "4e8877014c5afdf311f4d6797e12d46d85df2fbdcf2623cc34f490e079fd52df"
    sha256 cellar: :any,                 arm64_big_sur:  "3c746544cc6b4e54c969bba5fb9ad4f6ec2a35c328194bf1f6af09b4a0ecf88e"
    sha256 cellar: :any,                 monterey:       "2b3bbb6ef7ff85a84479b79b315662c7995ab95d5e16589121ae48adeb4ccd76"
    sha256 cellar: :any,                 big_sur:        "28d6753fd8af49a6e49049ef231dfd147d5fe4d85023f34993285eb18bf394ce"
    sha256 cellar: :any,                 catalina:       "63429fbc46559b912c603e486d976534b7496fe7ce654b86aec6c46047ca16ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc18c04cd148db312f3b001a2ba3b39885431b1875bc73c3e338a8502ce4ad9d"
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
