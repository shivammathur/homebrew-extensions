# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.14.tar.xz"
  sha256 "58b4cb9019bf70c0cbcdb814c7df79b9065059d14cf7dbf48d971f8e56ae9be7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "599e38fa17319f373c50ca3cd1d7663c693f3406db8f3f99ba0360d3f44106f1"
    sha256 cellar: :any,                 arm64_sonoma:  "b0ce501be10d08c13caa17749c09b79a11c3ae4bdf0fe4b8a7f4786b4e3c3c5e"
    sha256 cellar: :any,                 arm64_ventura: "210a5fe211da268d57d405b67b50f346657916147fe674e2f7f6d72d27f8c0a8"
    sha256 cellar: :any,                 ventura:       "362221aaf122678c259ddd310e4c18cdfbf93f8b8883520d3bc2092323309e89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37dc850e6fda79840bcc427bff777de336ba775825ee0499f3b9aa2129c27ea4"
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
