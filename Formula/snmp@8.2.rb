# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.20.tar.xz"
  sha256 "4474cc430febef6de7be958f2c37253e5524d5c5331a7e1765cd2d2234881e50"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "a553159953d673e4ccb2bc1673a95dfecab0e2bb42260b7ee9e2f32ed0f6588c"
    sha256 cellar: :any,                 arm64_ventura:  "4f86281494e40f493c7cf66cea5d969af1a62f296b13eb3bdff2832cc79a9d03"
    sha256 cellar: :any,                 arm64_monterey: "56c449fac6667a1e61a466402b1b4e0e6979de6cf41417ed0ca5663e2bc4b431"
    sha256 cellar: :any,                 ventura:        "6ea094c433a135cf56729ef01d264d0e1b896052efb5a3eff4b0f2d16bc54c2c"
    sha256 cellar: :any,                 monterey:       "8e0f73ee2a1d984284ea9faebbfe52161eca94acd071a48e6419ea8f45ff5bd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5cea87f5a70768c7a6cb580ed961bbfe754d1237b53e1a66ff49039046e23816"
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
