# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b7176bf97b38f49a10964bc64a1eda34a3d4a0f3.tar.gz"
  version "7.2.34"
  sha256 "e2f8001ac0694e3f024b56c3d5a9840d93dd806565073fd6500938f4759e4948"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "808031c5ad007f1476d9a29d0d9f3dfe2e49dc482787b82d40f9897576d56a12"
    sha256 cellar: :any,                 arm64_monterey: "9053a4e6c711929f91753aaf29afc7e08a5f4a73415e4ee32da9d31f14f0d3e7"
    sha256 cellar: :any,                 arm64_big_sur:  "c94a34bef3da7eefcb145ecc47f9d6524aebd2fa1f40962581a6c7e0aed0273c"
    sha256 cellar: :any,                 ventura:        "47d9c9eb095e6aa38c2926f3ceaa5d57e5b38038538671a7d3f26566ba78da7b"
    sha256 cellar: :any,                 monterey:       "6bf4bf34707dbd8e6debccea15c38a2c6814abadf1832245b6b62d7738d27101"
    sha256 cellar: :any,                 big_sur:        "83c7c0a8a77f81f1e0ee2287eba8ca9a3792264cbb1294b7438b54a76d4abe7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "afe64ae94d6d17f8375c9fdcd05a5ac5d1caeac8db3d8d6c82d0eced3ba1a8e5"
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
