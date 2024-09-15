# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.11.tar.xz"
  sha256 "b862b098a08ab9bf4b36ed12c7d0d9f65353656b36fb0e3c5344093aceb35802"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "1328e923cef13652da5c38a5b30154371a9c52ef4d4f542773bf5a222902f8f5"
    sha256 cellar: :any,                 arm64_sonoma:   "f9502035f2d6bd4c4b98c879012ed7a061e414aaa0db754fc1bd06542d84aefd"
    sha256 cellar: :any,                 arm64_ventura:  "1602d242321a8bb71fe219d0617fb501f45f628e62cccf2ab95d0464cac8d8c7"
    sha256 cellar: :any,                 arm64_monterey: "52ed669d9a39aff77575ceb3b3f0a64bc7357257674f137c52e61d0daf668a08"
    sha256 cellar: :any,                 ventura:        "6f210e91715e08695b2cb8a80102272f8ba25f6818bfd44bb17171b2ac1fb07c"
    sha256 cellar: :any,                 monterey:       "02c95eb9a35d2c774cb5b3a5c1c93fa3ee589b6e0cfe66cae3a959f972e89449"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f514cd6c0a8b188e94d1730062b6af62592a1d0860f22e4d0d8533701c987dcd"
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
