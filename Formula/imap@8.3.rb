# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7e4ca2e8d9fe9131eb24e29a8a508059b95018f9.tar.gz?commit=7e4ca2e8d9fe9131eb24e29a8a508059b95018f9"
  version "8.3.0"
  sha256 "4cf73ec4385ab0914416beb130e693cff6db92413fe288898f920c0f57346b24"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "4e6a9a1619cd3b63819db91bb1663e4e63e189cfa9d83224020da8ef0a1f98eb"
    sha256 cellar: :any,                 arm64_big_sur:  "d76ffe9b19b5a38f78f344a19c2f8ab4d050bb8bb8f13170e4ebf55d06386154"
    sha256 cellar: :any,                 ventura:        "7f7d89b2679bdee1d52290771e9a9c763001454c5683ab2e57545aced86857b9"
    sha256 cellar: :any,                 monterey:       "c444a72c6a92a4121a1a4463bc706c3c277c07fa25bf657c45b72ed7011113d6"
    sha256 cellar: :any,                 big_sur:        "11f2ae9afca7ff6595a23a2a05ad3aab244da802c7c3f883159a6560bc7e3232"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "60fb25c3906e6d2afafafebbf27c0cbf4964b4876a4e0687127a3685b1027fba"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
