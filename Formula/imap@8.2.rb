# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.11.tar.xz"
  sha256 "29af82e4f7509831490552918aad502697453f0869a579ee1b80b08f9112c5b8"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "9eb87f8b56b7e1e802d9a1e72e2008e35e8b3a6cb18dad8a19d74ec7e5c8b4b2"
    sha256 cellar: :any,                 arm64_ventura:  "54f023c99faa6036090d55ed451cf9ac68fe1b0d40ebd4aa8877d3d09de9a358"
    sha256 cellar: :any,                 arm64_monterey: "f5895641b5aee53145862ee8eb8e790c60065edba9dcd0761011e8a37e97e3e8"
    sha256 cellar: :any,                 ventura:        "12e22ddb7a9dc01855980fbb2c4ba87c26a5008158aa33cf1259e46ecf89da71"
    sha256 cellar: :any,                 monterey:       "61d046cde8b8469c19fde849a2b366084db9873d72d8b0d397e308894548d75f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5d13c54b7e2415c9526e6882c911379a640e47ceba3183ae0052de6fd29898b"
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
