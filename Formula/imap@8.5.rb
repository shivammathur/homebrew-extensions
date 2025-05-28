# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT85 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.3.tgz"
  sha256 "0c2c0b1f94f299004be996b85a424e3d11ff65ac0a3c980db3213289a4a3faaf"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4a46406309c250466b6e8b702e0c2240804a087070d634eaac3186f3fe3569f7"
    sha256 cellar: :any,                 arm64_sonoma:  "01380eb7f3494e0f0ecab2d6d2386e76c4eaa3a24e43ed6c4f0167447feb4ba2"
    sha256 cellar: :any,                 arm64_ventura: "9c36d440088b81d9d222ebd41959e303bd6a5dc55a5408422c89bfbfc4a1c931"
    sha256 cellar: :any,                 ventura:       "e9cb4069e47961bf1c637f095161efcb349804c7cc3d5219431acdbb0e9c6dcc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c63a1d4449c238e15d9554655cd8400643982ace8ddbdd2eff7cc47e28074382"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9ac7e54b4f59c81582334f9499cb49001d19f08bf141f0af3f9984a70516418"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
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
