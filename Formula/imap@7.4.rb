# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/39cb5f05b2bfaad7008f95e1b49b21005efaa64e.tar.gz"
  version "7.4.33"
  sha256 "1ef8f9836a28715b34645aa9335f66807a510c60cbd0ed3721aa61e2e00002ef"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "394e847db7e822e80cd9926d4fa31ea4e4ca89c6bf1f4659a1cdc050e1cd7f44"
    sha256 cellar: :any,                 arm64_big_sur:  "1ab418580ed4fecd3e9dfb25d00ea0f2431f78a26eb6afa176209ae8906f2daa"
    sha256 cellar: :any,                 ventura:        "b62a6d475daa696d56b4f4363d844433b0dc7735f293431dc37d3c377a5a5cbc"
    sha256 cellar: :any,                 monterey:       "f40f1f36a2495e54fc20f296728826cef90c8ff7af4219b8226b4814ae630607"
    sha256 cellar: :any,                 big_sur:        "1302715a1f3f548ad5a78b81b023c3b591e5653573be2a115852a0c7a85b8bf0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "09a05a4d921ca6d1f831877a42633e9b68b8ba1c431a3ec63d20ace1116f7444"
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
