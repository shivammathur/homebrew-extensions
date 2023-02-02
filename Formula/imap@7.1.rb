# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/3ec3a5352eb55a241b2e22e54e711b24f1542df0.tar.gz"
  version "7.1.33"
  sha256 "68e64a7a50b5649f3236bb39db32aef85a1082345ad266fd0af107d69b53b0ed"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "a6bba996db020ce88fb7534b5939197f7e46ed786e6e0cc77388464c096504a2"
    sha256 cellar: :any,                 arm64_big_sur:  "b5ff50d116bbe30581a73cbf61ace79edc479acd93b752359caff3a4ea94fefb"
    sha256 cellar: :any,                 monterey:       "8d163024ab4f6522bab23b6d093593b4afb8703bed29e628a8e9aab2d9733667"
    sha256 cellar: :any,                 big_sur:        "6881869cf3226924e918559c6294bee43f403daa0c7fbb003ffb668ff664098c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dadddfe4fd10f02da6ed64dd59d97634d7c032fad488825a351f4bd91dee5398"
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
