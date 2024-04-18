# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c6a5368db2d850e10899d237032dd4d7d116c1f0.tar.gz"
  version "7.4.33"
  sha256 "fd61fe2c759e485aedb011cc87ceb8e159dce63662dd4aded0d6aeb9231edcd8"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "0a78bef825851f607e633d7d4b7ddd8a6f960cc7ae709d1f34087a492d0e3247"
    sha256 cellar: :any,                 arm64_ventura:  "5aed5b1d87fe4efb643058f4a38e2ae2be691e24ed094fd5aba9234a17420130"
    sha256 cellar: :any,                 arm64_monterey: "f749369b9a82dc04e0da91ee2be3c9aa8e58c83df81755360880fd4212abacf6"
    sha256 cellar: :any,                 ventura:        "e22bf5c750d203325a33a5f69338c3c7d68adbed6468c12d41c06b7f0e938980"
    sha256 cellar: :any,                 monterey:       "22d47df47efe8c365c8a6e6356e3f5bd8618392f1cc05955eb6e7b40714b77a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cbbd4546b7b6fded52452e296e6cbeb2c01ac7030367fb78f8a5000240395fd1"
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
