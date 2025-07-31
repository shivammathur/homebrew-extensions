# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.24.tar.xz"
  sha256 "388ee5fd111097e97bae439bff46aec4ea27f816d3f0c2cb5490a41410d44251"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "d9bfa15aaa40de22e6de93eae823dbd3e81752828664022b59a5c669168980a7"
    sha256 cellar: :any,                 arm64_sonoma:  "7e7bd323f1aebb8bd20e8fbf53e01b2cdd9ff6a36858364692133162cdd8377a"
    sha256 cellar: :any,                 arm64_ventura: "960e831d4ec0eb57ff78d935b97321abfe0c0b958ee0b93c9b590d3813a679a3"
    sha256 cellar: :any,                 ventura:       "cca05153ca33bf7bfb5e126cd96d7150caf1f01fe85d392f253cc951b07921ea"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c671e3e53aae9d0480e4ed3a6e433425e462e10369cc4c6f8e39d92c3fb748c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d467c7079646d0ce0a14b7bc158e02a86b6601aea379aa7042e4160a51245c2c"
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
