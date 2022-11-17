# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/dd8de1e726a41fdbca6cbd4348ae63a74830a888.tar.gz?commit=dd8de1e726a41fdbca6cbd4348ae63a74830a888"
  version "8.3.0"
  sha256 "1f47a1c8155e34acd332cd3ada89f3d8163a8f21e9421f43148c943ebdd95be4"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "b083db4dd3035e1a1aa019d8937615ad80a482a0999d93cf3bcdb004ddfaffe8"
    sha256 cellar: :any,                 arm64_big_sur:  "c644a3e5788fe7f2eb7e9094454d500c5c84343243a95eff9c20b46ce8eaa160"
    sha256 cellar: :any,                 monterey:       "a1b15cdc367eae4d9e49a92a768600fc3bb8ff07dac1191ed9aa229706201667"
    sha256 cellar: :any,                 big_sur:        "93cc063fb6bcd33b0f22ee585c25d7a537391fc003cc770ce9c3a265257d7e44"
    sha256 cellar: :any,                 catalina:       "f3cb41831c09ae620b55a91d9f95c59c9d4c9e0a85d2aedd23a22a40e4e6110f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9c61f581a1b71ec86a6a7f7357b22bd4ca29efe74059a7b07eafda4d8397e434"
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
