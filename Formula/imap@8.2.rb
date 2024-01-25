# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.15.tar.xz"
  sha256 "eca5deac02d77d806838275f8a3024b38b35ac0a5d9853dcc71c6cbe3f1f8765"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "a92155a9f31b6b842b816b2225c740302f5d3e57b220e2816a6d3640e3c6ba7a"
    sha256 cellar: :any,                 arm64_ventura:  "6c54da18b20ce0983101cdaee8386429df4ceb5a8d588eeab4828590361f2454"
    sha256 cellar: :any,                 arm64_monterey: "d4b914a07acdecb082be65bf832f5408b487d5831a94a2eea1d1dc4ff0427fa3"
    sha256 cellar: :any,                 ventura:        "c28932cbf7c311641a960e6511f57bf282cde3e8a93c4d0bd954f803c51ed3bf"
    sha256 cellar: :any,                 monterey:       "6c44b5a6138e4423693519fc9cf990c59e8098855f3d827572489b57afa46df5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf953a5a9d1861f13c44c5c8e3ab55354a4ff322e9f2c1d0a2e84c357eb99b24"
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
