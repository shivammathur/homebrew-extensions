# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.18.tar.xz"
  sha256 "f3553370f8ba42729a9ce75eed17a2111d32433a43b615694f6a571b8bad0e39"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "368a7c260c85031cb8f786ac3a99eeae85c061cac4f177a298ce1d100cf3ee55"
    sha256 cellar: :any,                 arm64_big_sur:  "8e6c788520028d357f7ff2db8229379af44828899528d655786b78235ca75891"
    sha256 cellar: :any,                 monterey:       "0e8e1782ada4c9f4bb4b2406d09f947478803f41c11f8d03a27f5797de00c445"
    sha256 cellar: :any,                 big_sur:        "c192b0d657987f190eb91bff1a2c02922000132087aa4fbd36932607a6e32561"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "db50fa1b51f10968888af6aa092d95c3d660e2c3fb3ebe9ecd3dbe0b71215f30"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
