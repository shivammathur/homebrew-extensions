# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6729276684ea20b42a7e44cf0a27d303308d3578.tar.gz?commit=6729276684ea20b42a7e44cf0a27d303308d3578"
  version "8.1.0"
  sha256 "f7b431e1d44171bed7bd5a7c120d883242d2ed25081dcdd467ec8e4c9161e0e5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any, arm64_big_sur: "22f69ebd353dd25c08bcedd345be7cc4422728c4272d444d2524824233aaae45"
    sha256 cellar: :any, big_sur:       "d4600e0cbe45f9f8122c6f4c5b0090747ca56cf0077e3997d8e68ff9ff4d1c4f"
    sha256 cellar: :any, catalina:      "df9dd7d319d6a173bb4f3943d8a921712dbdf8aed8523905d4fcb2780e10965e"
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
