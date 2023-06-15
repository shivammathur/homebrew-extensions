# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/96ea06a1d9b115a138bd9e16a3ecc7901ae3abf6.tar.gz?commit=96ea06a1d9b115a138bd9e16a3ecc7901ae3abf6"
  version "8.3.0"
  sha256 "dbd7f3ad581b6c760bd5215137deb582cc80608bc8968303a64c16b5aefc84a8"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_monterey: "72b49ad8528bc0057b5d39a8418a2a0b4587b7660bed7f1b69fee4aadcfac3b3"
    sha256 cellar: :any,                 arm64_big_sur:  "330790f8066267b2e5865fd7dd81db14c026adf5b3e27b0210a7ce982656ff70"
    sha256 cellar: :any,                 ventura:        "a3333646a20fa1d18e4e22d9582ec7e92a89693d14ac60c2b3d1ae4af31bd5e7"
    sha256 cellar: :any,                 monterey:       "6a192842a4323e4d1f4727ffd723421e05b726cfe5ddc5866005a7ee7d4733d7"
    sha256 cellar: :any,                 big_sur:        "5fd23e85649bbfb0da115037fa36d374863ba8faf4870345d6c856800d421cea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9ab01c83d52217285ade6c137ffa452b7be339addf5cae0fa69ab27290601424"
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
