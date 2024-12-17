# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d6623472bf262e3bd7f7f9218bb1fa9d411cdde7.tar.gz"
  sha256 "72f4f2385928664f0ae600d5e6c7c29ef643960a981676f218f4d87c400ba53b"
  version "8.0.30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "0a609f3fb45bcdfc4520a9dcdd1748abc982b2c2ca333c0120c1996b6624a1d5"
    sha256 cellar: :any,                 arm64_sonoma:  "021dbbe201542c8b8412c88b6d9160d7b104612e25f78b013f74f75e233d025b"
    sha256 cellar: :any,                 arm64_ventura: "b361eb4e8547d0cec7a335e5a85349bbbb1a04a98e8367bc025879a7c5dd4b77"
    sha256 cellar: :any,                 ventura:       "f9cac18149cd2d179daeb26850fc6f0f1085a6292b4d257756aa681fbf2694e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8df2182011cd3f4df41c42d8f833738644b35f9eda233d673e1c26d26102b46"
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
