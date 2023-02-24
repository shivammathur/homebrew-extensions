# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8995f602584a5267999f51cbc73f8c03eee36074.tar.gz?commit=8995f602584a5267999f51cbc73f8c03eee36074"
  version "8.3.0"
  sha256 "f20f5b318b780fc8436e10988dc407e4dda61220f4902ae5e90e3a1178b6a52d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "0a410bbdc4c1b9e67b28cf8e166c3da5a826d1385ca43611cdb954ac692c8a29"
    sha256 cellar: :any,                 arm64_big_sur:  "1ea1726b3adb8f8594964b4f2a07b2853060b0d528ab4e92f60fc069de2f40f2"
    sha256 cellar: :any,                 monterey:       "79d54d347338bd8dc1ce331716086b16e527461058c0fd7f938617fe89063c6b"
    sha256 cellar: :any,                 big_sur:        "52bc5b5d669f95c8fc4608e463d7105256cbf0ab0aa89df81f661fd658f7c5fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4d8fe7fd39ef20167a6482657eacee06646080c9e7165eeaf506e3f20f6e4498"
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
