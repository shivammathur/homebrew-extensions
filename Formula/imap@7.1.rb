# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/db1e0280ac104aedda87b64fa8403a8665af56df.tar.gz"
  version "7.1.33"
  sha256 "e211aa6626ff03b352bc1ba3556a71129fd8f94979861e4991858bd9f6e734a1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "631541dc26381fcba75ff8598e1b7e60c56535d34a9528cfecd53ff500ad01b8"
    sha256 cellar: :any,                 arm64_big_sur:  "127abcd666ad6d9becffca66f295bc39a1597a736cfa4cdd82512760110cf27b"
    sha256 cellar: :any,                 monterey:       "de6cbb61b3ed34975ed034fc78599f36da5b699d7ea51995b6adfd82f1165efd"
    sha256 cellar: :any,                 big_sur:        "dd61d9663c3bde39a0a5f31b7e5a6322f5591d75ffae3736bc5aa46cc137ac64"
    sha256 cellar: :any,                 catalina:       "9b9468da18b08d33f546b24594403f2b6c3158f3b83daad8d2a0fa6c01b61b52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48ffe6f144930df4706c18b3fcc22c36b0f3b864c598a68196bd8d709942aa00"
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
