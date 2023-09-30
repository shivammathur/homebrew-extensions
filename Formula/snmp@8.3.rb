# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6a2b8851556071a5cefa1297e1a88bebc4753081.tar.gz?commit=6a2b8851556071a5cefa1297e1a88bebc4753081"
  version "8.3.0"
  sha256 "ed39bef1ddcd0bebf36924ed69a01d062f5b915346f9e06258c97fb82c257c5d"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_ventura:  "f556812ae42845e927fbf2faafbd88ca685a4fbd20346c1b544b3682989d5fd0"
    sha256 cellar: :any,                 arm64_monterey: "3ac353272111dbf5930cf22f83502d090e320dcf6a60da4c19fac7b2f64e4fec"
    sha256 cellar: :any,                 ventura:        "a0398275139bdb6763ccf8312a7482ed195dbc20e6ebdc989ef99f168913f061"
    sha256 cellar: :any,                 monterey:       "6a1a7b13dba73e49ffd1d2f87c4baca54f87ed516c7729dfda197ddb47214639"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e58f41c98fac528aa495d8007cb2526bb25a8040eae78dd9fb1096dfb4221545"
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
