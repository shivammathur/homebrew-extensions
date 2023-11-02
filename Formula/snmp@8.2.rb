# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.12.tar.xz"
  sha256 "e1526e400bce9f9f9f774603cfac6b72b5e8f89fa66971ebc3cc4e5964083132"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "a2a7f91d383a45525840f687dbed5c398557603866c4b2e1c8b011f70378e0b7"
    sha256 cellar: :any,                 arm64_ventura:  "5f1c2c6666ebc5c9ea2f676e5ccf466e6563f65db454c033b4de421f1a3c1978"
    sha256 cellar: :any,                 arm64_monterey: "a1f27b348dd47c4152dd4eef7544fc08a3f8fa485518084f6a97bc1f97ea18b6"
    sha256 cellar: :any,                 ventura:        "b5a85ee38a6adc6625ea66a0b8b1b236686f30c14c288cbcc6f3708af5f498a6"
    sha256 cellar: :any,                 monterey:       "0018b671c558a14ba4e864094cc01ca602393ae033eb91e4346f3c09ef361a4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6fbf6931da98d78935c95b7759050b749ddfd30625809044d45db1ebb316f4e5"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
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
