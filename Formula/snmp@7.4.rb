# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/27218a7fe4e0e2bd76621cf5743fab0f0fac7f11.tar.gz"
  version "7.4.33"
  sha256 "015ca494623cdb4b148541428efb1f9455c7a04730b29f9b236f3c7de3f888bc"
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
