# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7b4b40f06f39f1dc05fc4be8531fa3d582062488.tar.gz?commit=7b4b40f06f39f1dc05fc4be8531fa3d582062488"
  version "8.3.0"
  sha256 "780d0f93a5e2308ee3ae6a16a07773958678cccd71fd4ff0d2ce31c53178a4eb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_monterey: "f91714905260a756e2ef79973adf2a3f683985b103a6ca1f2a7be5f5e195f9be"
    sha256 cellar: :any,                 arm64_big_sur:  "474e624372f83749a4a149fa7801e9a5e987efdc854e193a8565bcadc492b6b1"
    sha256 cellar: :any,                 ventura:        "24ad19614b5c3ccd5513ffd506776217625b178c38c76d06089c7450a86570b2"
    sha256 cellar: :any,                 monterey:       "bebb6f654dd766e839fddff6c88c798e78921da3c9662fc272d36a3717061a5f"
    sha256 cellar: :any,                 big_sur:        "b3d25d4b481f9a9512958aa4ea404c7a20eeb2f5d170672f1b9967965ebb563e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5c2a66cd4a6726f98f07925543cb6ec940102be4c0f5f333fb3625fe903c516"
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
