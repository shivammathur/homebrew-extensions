# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/ce452e29d3eb764ca803f6faed9ca252cecb5b66.tar.gz"
  version "7.1.33"
  sha256 "d8aa356f34264d02acbb50a35dda9ed00c41b9a492f0a94bd7322685b96760de"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_big_sur: "7337b4beb0ffa6d014179e69e0dbec66011be56e3fb96e4effc9f04b620d6d9e"
    sha256 cellar: :any,                 big_sur:       "90787b414087d66a117afbb44e37b0f6a035187ecebd525c4cfd5518690a61d6"
    sha256 cellar: :any,                 catalina:      "125f92d1f398871d694ce651d3ab25ad461861890da4dfb02800e5baedc24729"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e3b4feb6d320e7939ba4f99f1be61e9ddc533e56aaa73febde7d08ea8586b50"
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
