# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c9b656d85cab6bd2f0a200276cd59f4142a48472.tar.gz"
  version "7.1.33"
  sha256 "900098dc8cc12caf1e33cf1174ec8d4abb566db95145c4948cb7a61fe3c831ef"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "eafd9e078e84b03c9f8aa19ea31c6c9a18d4110931df7b79475bc2585530abb8"
    sha256 cellar: :any,                 arm64_ventura:  "ccf6756441d1b5ed223b085d6eedbbd9076d490ee691eceb1f41cd2c2ada0b2f"
    sha256 cellar: :any,                 arm64_monterey: "d4e688f0e90bcb6853a7a386b9fcd8ac4e58c14a3a1a4d26be001dbd215a3869"
    sha256 cellar: :any,                 ventura:        "cc84dc330f0de4a601f45fa2a1f6d90a1353585c8fb132ad1dde02e06e8e6740"
    sha256 cellar: :any,                 monterey:       "9ab126efaef1c2d7fc41b102a158df31b9879501a206ff29d0cf94aa8f83907d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4ee8f4d5ee244ed985b92fbfc5d2599e9cb81b35f3a53a98e5f3fc6331ab9e7b"
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
