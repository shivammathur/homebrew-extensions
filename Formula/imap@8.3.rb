# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/63a7f225ea638a18c875adcba067e29bf117dd08.tar.gz?commit=63a7f225ea638a18c875adcba067e29bf117dd08"
  version "8.3.0"
  sha256 "f7dd82ed41d8f9a0d16364550264109c709a2fb2897f5835f8bc309e57946b1d"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "65d0ff810713c9c788eb3aa059c5f2b670f0f95f9bfc5ef1321f7ebe80027a34"
    sha256 cellar: :any,                 arm64_big_sur:  "b63d693ea6160159a0dbe67f936a58dbd1cf86ad4b7c592d26cca601616b7be5"
    sha256 cellar: :any,                 ventura:        "99752c7ea4ebafffc8068a78d9aa8498fb895b6d5ad47a84e44894c22b01e929"
    sha256 cellar: :any,                 monterey:       "78f1d1a36e29341ab6490ad27a635e53a07f6924ed94d8a8efc5642917016752"
    sha256 cellar: :any,                 big_sur:        "885c1ffc0fb772f57ddaf1b2b8d15202a57b0300827a8bd137c51d3e032e676e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ad49d0dca39cd14a2e54e2654ee4a567316f7981431f683efd5f5b2e5616e3fd"
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
