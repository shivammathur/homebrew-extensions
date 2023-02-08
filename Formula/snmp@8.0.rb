# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.27.tar.xz"
  sha256 "f942cbfe2f7bacbb8039fb79bbec41c76ea779ac5c8157f21e1e0c1b28a5fc3a"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "3634f9101e5106ed3608cf6b56b3c652ab2bb10c0d53832dfebb2962c5413d81"
    sha256 cellar: :any,                 arm64_big_sur:  "6336fb4c1cc1c1f4dedc493671933a1ef273587ce6360b3d99d948b24bdb29a0"
    sha256 cellar: :any,                 monterey:       "7634628fdecd51b4ff01c2d5173a40e84f4d978d09ce34673b0905f98234a1e8"
    sha256 cellar: :any,                 big_sur:        "a93c1bc2ae2a17f57287b4c009904f7d6d52bb3c8008c782c49c5a6154094ba3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eaee36edefeac830902ab85836846495505f3df01b043a46e202e4895155e701"
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
