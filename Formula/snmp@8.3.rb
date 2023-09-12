# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2440af0f978465b33eb5976a5eea11cffa70ef75.tar.gz?commit=2440af0f978465b33eb5976a5eea11cffa70ef75"
  version "8.3.0"
  sha256 "ed781bcfc827b257d38ff3c9489a18e5e30effd32cef1fd70a953dfbcdf54e7f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_monterey: "6a209fdffd6e299a436d7b6886c37860a312a702aeb8708fa969088d69fa2f07"
    sha256 cellar: :any,                 arm64_big_sur:  "d0c9d226df84be2ce8289563da53b891547f3d179ce1928ab7bab769cccbaa00"
    sha256 cellar: :any,                 ventura:        "c0f7a44ecc438e55392584362e0107f723a30c047bb6576ec21b7fd7089a08cf"
    sha256 cellar: :any,                 monterey:       "a94a796af6588af1204040c75d5d01be042ffec3a57db0f8ed06dea2dca54b49"
    sha256 cellar: :any,                 big_sur:        "67608869d1f40a099ec9aa378c8c54af22c7bebaf365b50620b3b737e7b05fdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2852c0fc843271d99d81d1117dd55f42ca5daeb72adb3c9b20046c8ff1d55e74"
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
