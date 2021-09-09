# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/679bfb15226ce4a7e3f485ed9285b82371a699e6.tar.gz?commit=679bfb15226ce4a7e3f485ed9285b82371a699e6"
  version "8.1.0"
  sha256 "c87ed5316a28fd812734b6f30f0181d35eb3978b120c7f35ba88ee4b789715f3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any, arm64_big_sur: "7de04a54830e8dcbb8b72ac106524e083ad2b6fc012a40efd9ffc02dcd9783ff"
    sha256 cellar: :any, big_sur:       "dd285da3359f8d0b1cde1ca992818d66ded632dc68f4710d38a88ebdb514e5aa"
    sha256 cellar: :any, catalina:      "5dca693130f547e10473cb75ec49cd4355bfcd206bf84c4f037cadff48e05148"
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
