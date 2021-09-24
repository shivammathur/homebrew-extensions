# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.0.33.tar.gz?commit=5a3fd452ea151dbd747c90b5089001578bf4e18e"
  sha256 "6203a269840fd14786ed95dc2cd54a07e9907508a891e77b4f8f0fdd4773806e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_big_sur: "865442512939de016cf92e826b4147e23c5634a9c01936d6c9da1acea74c2f3d"
    sha256 cellar: :any, big_sur:       "7509f1d763535a87d1131e4123e236ec5d9f6fb1810a11174d70b99b35190215"
    sha256 cellar: :any, catalina:      "c863f5d9be15212e94feb712279cf5c208d541aa3c64dc4bcc09ab17e48e5fe0"
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
