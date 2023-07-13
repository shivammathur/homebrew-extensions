# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7c5a57077ab6cd48eb274ca54f130e2eab3e028d.tar.gz?commit=7c5a57077ab6cd48eb274ca54f130e2eab3e028d"
  version "8.3.0"
  sha256 "4ab7442af6e8a9d0d9b38087c0ac66fc627f86e890b0659e3ef1d4e7aabdcc65"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_monterey: "653823f4aa98d89d8f19a46bc1be4eaf1c3570002609083791cd0c056e46f953"
    sha256 cellar: :any,                 arm64_big_sur:  "b963b526b334acee8d65cd804cbc1130ed4c4be5146e935a22f14ea5b388d635"
    sha256 cellar: :any,                 ventura:        "f1e5a2a774d9fbddc411f3c60172fd3371fe68750df1c469844547adc268c731"
    sha256 cellar: :any,                 monterey:       "4e25bcfd99e6f5c2ba5521c669e7224d35a1a2aa7ba1b7ed9c940e843824836d"
    sha256 cellar: :any,                 big_sur:        "4bcb4ab976ba6b7b2b6ab46d757752384424e395ac409920b966d322462c47ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "56ea3b4e58065c0e1239366417a0094b4a6ffcd28ff70b3f8854ae2e5f97b892"
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
