# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/be46545ee03261d90b3df644dade64b9ed01d21b.tar.gz?commit=be46545ee03261d90b3df644dade64b9ed01d21b"
  version "8.4.0"
  sha256 "43450b6f800048336f37e17304d0c4370640affc8e3f2631352834bebd4ed6a9"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_sonoma:   "958c86f4f0e15d6e27373002eb5fb5267edea463aabc51f061f8900c3f9d3453"
    sha256 cellar: :any,                 arm64_ventura:  "4acef779230f1d1ce65ac0230122c0bb403b9d0a42373316933910513573cb0f"
    sha256 cellar: :any,                 arm64_monterey: "7e87e030a6cd547b3bc0de43b4360a2867ce3071fcd7e57466b26a76dfe79d47"
    sha256 cellar: :any,                 ventura:        "5102343be94b30b4342233e4626f1ed2c485b32971c175f1b385d878f2ac9c74"
    sha256 cellar: :any,                 monterey:       "86283a3753c8901a9ba6ce21e862a578f16f6b90c2672b8c367df698c3b77401"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "944f4c6770f63cb4325fdcc17603a152896112cc286dc50bb520316988e20d2c"
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
