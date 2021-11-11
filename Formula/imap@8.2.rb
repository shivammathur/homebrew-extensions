# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4508196cc2dda5eb86b7f4440e1ccb8cdac3d874.tar.gz?commit=4508196cc2dda5eb86b7f4440e1ccb8cdac3d874"
  version "8.2.0"
  sha256 "f5002760d6ad2ce62d1a63e8b6cafc2513965b4cc4430dceaee3696c6f8f4b30"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_big_sur: "129dd5d215f6919fd075723b378f36c8265cc47838a7bf035eb69d07773df98e"
    sha256 cellar: :any,                 big_sur:       "490b73a92d04c999d35b3709fcaa791af0327454ecfb474fe3b61a6e9789c843"
    sha256 cellar: :any,                 catalina:      "b150bbc01a7111e6c7adeeb22e93ca8a181aaabbbb49cbfc40849526131f0e99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "845f464c77140398fe3dc03feb3492623d21a755ba692c7b30ad10b4864407aa"
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
