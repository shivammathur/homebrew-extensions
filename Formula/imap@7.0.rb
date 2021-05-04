# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.0.33.tar.gz"
  sha256 "db37d9fef4b3e776885253fdc2281723f0b33e0f89bbffe1e3927801f19f362c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "bcf9bb1bf62186d78f7e3e9fd4b190bf2e86a7433d36705bac99822d184501d0"
    sha256 big_sur:       "28d0877bd7ff64414873073998e575ab719285e50a336844e3d4ddb01bee4529"
    sha256 catalina:      "bc7927cfe73e68a50624a0af047d28d50138cbb6a175b06d09be39480597c52c"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
