# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580ff94139aa2f0383dae4da1d40fcf726b27a31.tar.gz"
  version "7.2.34"
  sha256 "cbf4d0b35b53b32b303b7e7ec171acc097094534b1e068b2c66abfce6008c4c0"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.2-Security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sequoia: "de5cb082ad012f113effc9da95b4c12f5bc2c56ec56987e416c4748f1b5d86e1"
    sha256 cellar: :any,                 arm64_sonoma:  "ea1891ed0997f28537c59dedf0b17cdd5def632072a480eb0cc0c2ebeb45387d"
    sha256 cellar: :any,                 sonoma:        "d17055f2736cd760422b74bc5ac9e4675dd8d2ab0601fc713519e25c2a4f1b8f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "90c1a2c3f5964d81192131c22bca7c86bb2f9a446de6052819eaa3550375501d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8db1be9b02451a91e6649c2cd06e3c2262e2a1ce0c17fcdf635b5f6f8636c178"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
