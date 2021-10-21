# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9962aa9774087e8968323f84e16314137b8cd25d.tar.gz?commit=9962aa9774087e8968323f84e16314137b8cd25d"
  version "8.2.0"
  sha256 "102946b86fc677bd5767b5bcfa2a1886186eea9c904091d22f2c0ec5d1ebb597"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any, arm64_big_sur: "952edced383f92de4f1278949286b3dcc5a9181310c20c221788e9db6f7e05c5"
    sha256 cellar: :any, big_sur:       "7b97093c91df2942edfccb42ad36184b99df0823d49af99b173b15820ca9485e"
    sha256 cellar: :any, catalina:      "3f146bedec90fbd5fb82e9ac0768e6b1f3d1e4ca7dec342cae9958e348075b94"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
