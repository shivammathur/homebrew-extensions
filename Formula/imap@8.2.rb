# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9bf61d657762c5714b70808f1c03eba463c0893f.tar.gz?commit=9bf61d657762c5714b70808f1c03eba463c0893f"
  version "8.2.0"
  sha256 "ce5a0df88d0b61bfdab0716e5d82359c8b9e014011180f0190c4dc0adfa80e6c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 79
    sha256 cellar: :any,                 arm64_monterey: "78bafe48e63c86c75182c3a330feeb6ed3ab4a737ed60ccf803152bcad95ea9b"
    sha256 cellar: :any,                 arm64_big_sur:  "93083df91b165cfb39737f7e1102bde3b4577ba17db857c2f6814350bb693728"
    sha256 cellar: :any,                 monterey:       "8a681851807159f68ca76097ef8ff5d50a08ee6997b8415d4bf5c70c8e1cc86c"
    sha256 cellar: :any,                 big_sur:        "583a35bc34ff289443704a7506db21cd8b137e71a4de109edd7fc2e1602d04fb"
    sha256 cellar: :any,                 catalina:       "e32f46bd0f1a3d9cb90450f9221340fabab5e6e697d3b63059fad717cf4ac1c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5411ae832c22c9694047f89feaca94e05f702d894a58b1d4055d555a70cadc78"
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
