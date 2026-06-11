# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c8bf06235fe7fd4fa747bce70f7824a03823a6fc.tar.gz"
  version "7.1.33"
  sha256 "edea2c9b62a4cfeecb8fe0e377a2c64553463b195db251385b000f32645e343b"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any, arm64_sequoia: "d0c6e9dd21c5145afcb737fbecf025fbdd2e3cfed95f9c900fc62875f463e728"
    sha256 cellar: :any, arm64_sonoma:  "f5b9edd320669ed2eb447f92b4218ba8fd7e3cf6eb2c12ba0882935fde7b486a"
    sha256 cellar: :any, sonoma:        "3b6c72018cd4c3947f4b59162dec5f70c1f459b81543c08577188c970f44f04f"
    sha256 cellar: :any, arm64_linux:   "43449a78c4849a52dc8236684f97b195651c23878b89fa3e53428743a063c0d9"
    sha256 cellar: :any, x86_64_linux:  "b30574f7a9a817813c33c0f4589f0ec21887fc129ca9c103cfe84b56088fdfce"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
