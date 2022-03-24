# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0ba92163a0a6927a1997e76c16adfc83488c27af.tar.gz?commit=0ba92163a0a6927a1997e76c16adfc83488c27af"
  version "8.2.0"
  sha256 "0037f5922133e74265bb2cc69f5aa9067ff0951ca56085c6f762410f9f20535e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 40
    sha256 cellar: :any,                 arm64_big_sur: "379cb92a90c47909f13d81184065d986dcfa36c818ba5fb825ec0bcad967990a"
    sha256 cellar: :any,                 big_sur:       "1267d55c48ebf834086afe6ee20597845d505e771100def0face80abc5a202ba"
    sha256 cellar: :any,                 catalina:      "32299ffd97c19874b1464ce73a356a12bd05b3c53444341c041f696eeb76704f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "92661f6d9658910ca3b4cde9ef0f63594490792fa33e71e90eb8ddbc5123434e"
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
