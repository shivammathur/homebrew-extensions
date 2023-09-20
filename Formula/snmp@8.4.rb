# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/55432bfa16c8d45aa255ee4b92038a99022cd24f.tar.gz?commit=55432bfa16c8d45aa255ee4b92038a99022cd24f"
  version "8.4.0"
  sha256 "37df7c55824ccede76caa7ba58ead42a517c16ca2e6ec6d71e094da0de9a01f8"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "68523828ced8bbfa1830a2d12e3dd677e60335d5095de0e96512b16c892c630d"
    sha256 cellar: :any,                 arm64_big_sur:  "f1e1287a31b469986c8eb19523f871614c407febfe06357d9482f8a552f51d5e"
    sha256 cellar: :any,                 ventura:        "25257771bc12902007f3a3af631255a186824bd84075ebe411291a091dceda3e"
    sha256 cellar: :any,                 monterey:       "0e17ffd245bcb6ac5bd68484df23f841f57d02e060695b47b69d67e3f66dc9e3"
    sha256 cellar: :any,                 big_sur:        "4bc92ab8c144c0828b17086905ebe256c62bd5b27803a392173ae4909cb7ce97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "00cdc91e2b820596c902ff323c89c42913b67e0003d2c0b9dbc5d391eb32c836"
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
