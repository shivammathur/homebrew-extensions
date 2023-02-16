# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e4e699e81f4c427582691bd0dae25f3539c3e65e.tar.gz"
  version "5.6.40"
  sha256 "95e65b163387e14ab72071e5f4676b8178298e69c4fac7eb37970dfa78daeb20"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "af73d23dc1385d23bc7f2c140e749e3fbde4af2e11c1d4dde14a11e37661db55"
    sha256 cellar: :any,                 arm64_big_sur:  "714bdd947ffc026d5f379393c87c96e5be2b5e63da6ed194cd7d38a2340ab7da"
    sha256 cellar: :any,                 monterey:       "9402e312f14133319543fcfe37d418f19f10257a45e2a3dcc8fee6dac3a0ca50"
    sha256 cellar: :any,                 big_sur:        "4fb5fa8b71688a50811a4fdb181ce268cf91e3bef54b1a6e9cffc7f5d57007b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e179a3764462c06e60ed07164b27f7eab5af65f3f53d5f18ad9bc34d99434033"
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
