# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/789867e844dc0465fe01a703a1bef2a7dba0c62b.tar.gz?commit=789867e844dc0465fe01a703a1bef2a7dba0c62b"
  version "8.4.0"
  sha256 "50d54b44e79ead9c0d63a0224328a06f2988c82e73f0fb46b6aba3bc30463dde"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "df97068507ce16c875f74faca35b3490d343a76fbe6c4f2ab565f867ac6d6fa7"
    sha256 cellar: :any,                 arm64_big_sur:  "6067d57278f973e5c7a3fa2d2539f827f39b159a2e0546506039a5565b0e0eaa"
    sha256 cellar: :any,                 ventura:        "5140079487eb437c8b5f11e9b3606950cd833f6e69754cc72d23edfbd053d274"
    sha256 cellar: :any,                 monterey:       "85f1db06978cb50e6106f461d55acb3e55e2db9ee8852073703339722a31bc7e"
    sha256 cellar: :any,                 big_sur:        "5a0299e87ece24b0ad183f66e0883cbf1ff6a3c2781d379b2047dbfa63d420f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "452c4bdfc50b72af39d7ffeb30d01b4ca9d967ea18b4f0b9f3dace2ce816357a"
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
