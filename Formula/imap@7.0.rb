# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d24277d03f89b9bb19547f7c95a013f551b35a86.tar.gz"
  version "7.0.33"
  sha256 "4b0e38edb3051d066fdb00e754f63ed7c32efbaf2a2bf0ae955af319a0da1412"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "830ffd825880ae4ea4c707d1e19c00a30f235794f646cacf9c587658804672b4"
    sha256 cellar: :any,                 arm64_big_sur:  "487c512c7a3e2c441806b9a913392cdfca010fd1ec3d6a62b44a20e1a868b2f6"
    sha256 cellar: :any,                 ventura:        "3ea91726e4eae7f6e42945d4d97b8b3b820c6f4e7f85f8b157922d161f9da075"
    sha256 cellar: :any,                 monterey:       "e01a3a11dca55ea71eb9851e2f6b7c7bb6a91f637b37f16f386fa8a9b3cefdb0"
    sha256 cellar: :any,                 big_sur:        "a72930e6c2a3117381324203dcfbb7f53359f11e723394d4e059d5e2911cc624"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "80ee28bd99124b55e5da842c9f2c36c109b47b454181c7d47a1d6fd8cf560461"
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
