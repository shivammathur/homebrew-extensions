# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.11.tar.xz"
  sha256 "3005198d7303f87ab31bc30695de76e8ad62783f806b6ab9744da59fe41cc5bd"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ec5db1cd9dbb9c277b693f0e2c77cb4da227f01354b96cbb3014337afa4486de"
    sha256 cellar: :any,                 arm64_big_sur:  "8269aed041813faac51de142d90926ec6236e8f6ec5f7160d93a9d898d80d422"
    sha256 cellar: :any,                 monterey:       "7c10a1a8cbfef0e54f58dfd8c398be4eb9bedccd3f577ca2e7c7bff2fa46e21b"
    sha256 cellar: :any,                 big_sur:        "360d90c6ce55d0d8a12852a26d1e839c86f151743e01c952641161d0e1e3c348"
    sha256 cellar: :any,                 catalina:       "6da419631e770979075238ce0feadb51c6deb95fe6c904ea41830af43ee87805"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b1124725ec873649c0c82021c5057eff9ba1571b26221aed281486a3f22cf197"
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
