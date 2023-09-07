# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d693f0a4dcfa41da5d7b2c65dd8d80c078c59808.tar.gz?commit=d693f0a4dcfa41da5d7b2c65dd8d80c078c59808"
  version "8.4.0"
  sha256 "b27c295dea832bce68a5e3151343b9151de45790915789fcaf03496fd04b3e53"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "5e7cd23e0652ef6eb1c53b42e565a3f7ac8f0747f1bad4400fbed13ff9f7b69a"
    sha256 cellar: :any,                 arm64_big_sur:  "a42f838931c549ea2c2c18b8e7fbd7e1b8877873d3b326ab8a2b4ddd2e2e2406"
    sha256 cellar: :any,                 ventura:        "7106711a51cdc3c2d5ca7a88463f39de77e150a05e2c82ed3cc151e47629c4af"
    sha256 cellar: :any,                 monterey:       "1cfd083b34f9c0d67b32a0b3dba142d42709e2caaf4c8e2c07162223bad30a79"
    sha256 cellar: :any,                 big_sur:        "c29f92babe1469a00fc3b8d4aa959276aad9c9b9eefa9383a6076075803ff19a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "650c4d0106ad99514b44105e5b9324f37293ccdc1a179fed6d1f631da6a894b0"
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
