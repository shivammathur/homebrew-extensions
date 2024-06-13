# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e67b7a23f95e4d239f624a151e2be14102b94a87.tar.gz"
  version "7.4.33"
  sha256 "e8ae3ae4351b0924d048567eb729ff908dcb3121a835800a8e26acfcb6020c3f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "6f134d8992ed09ad7fc6f27635dfd51981be93b6fd9b71f965865a5cf6e21c41"
    sha256 cellar: :any,                 arm64_ventura:  "d8e4007d9bc7dcee2f72ef5371adb184cfce2041823751f448bb20c00ebe59df"
    sha256 cellar: :any,                 arm64_monterey: "a7b79e5f70f4fa9126f7ebcdf331b3def45a82428f68cba9275b871dd2ddab75"
    sha256 cellar: :any,                 ventura:        "4a29d1f02669a02da474d8e7e73208f2e9ac7e3dfae67d17e29c29c3c247e670"
    sha256 cellar: :any,                 monterey:       "8a7985811c424583c03064ea38ad4a0fc58a27b5ae174e028a3e19094d0d9d73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2821eff3023f6870505f374c301d219b0e99d68fdc8cc2dd9ab30279f3f6496b"
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
