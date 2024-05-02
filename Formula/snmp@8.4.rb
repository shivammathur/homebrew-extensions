# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/378b015360db45286b53b86181faf38ec504bc3c.tar.gz?commit=378b015360db45286b53b86181faf38ec504bc3c"
  version "8.4.0"
  sha256 "b20f67106c297e0acf3dd0041cb81d29977d4329a2a8ac5b8870ade53fba72c4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 40
    sha256 cellar: :any,                 arm64_sonoma:   "0b49dac4e98a7e732c41fb1000d667e16cad27b076e60cff954af507a42a50eb"
    sha256 cellar: :any,                 arm64_ventura:  "4433fefe0f58e9b6a042bd8687a46da05f1007d5c6ca4fea3c12b48c262a68b6"
    sha256 cellar: :any,                 arm64_monterey: "e0887c73f1f14c034f18b9aad2f421b7066495b24864001f3e3c224bd748952d"
    sha256 cellar: :any,                 ventura:        "8a3515f05be446c72fcd39e2cdfdb0dfc7d59192549dead8498980d76702ebe6"
    sha256 cellar: :any,                 monterey:       "e014dde118685a8ee6fc815ed98dd0ec4ab424ca2ddef49611095e98077f4bd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d979389d752e0ad8a2ed2d31a6778a97d268f4220e3b756a7ca2502cbd73ba25"
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
