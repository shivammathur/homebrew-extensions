# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b27d2fffbc551cebc3696718028bd22ebbc93dde.tar.gz?commit=b27d2fffbc551cebc3696718028bd22ebbc93dde"
  version "8.2.0"
  sha256 "8ca708e703222178244d7c484045a0e44fdc3e5a58a86f56db08efd12cd18bf5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 30
    sha256 cellar: :any,                 arm64_big_sur: "8323eed5bcb28f826c10df90bf3a14091af92ed39b009f9e3e5be96b016ada59"
    sha256 cellar: :any,                 big_sur:       "7760784eec4b568ef120f575223bd7fcbc7431156cc49e54a18bdb39607ebda7"
    sha256 cellar: :any,                 catalina:      "35a86cfa77344d04aeb359ec601151df923cfea60e7e639dd27bdc72f9fab50e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1389241c326020e30e9780247cda30d189ce2132b6438da5f325ba9ab08bc4e4"
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
