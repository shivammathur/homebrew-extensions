# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/bc9eff539cbcaac98720ab7e8eb73dd5bdffe12c.tar.gz"
  version "7.3.33"
  sha256 "83434d34cfeb96c31010fc9e3fdd0e4f67cb3844bf2dffd760afb53270aae286"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "28c021342da8c7eeaa2ff5c714ae90f0aee4bea7dc1a264ecc683bc1d9fd8059"
    sha256 cellar: :any,                 arm64_ventura:  "749fa591ffd0207660b8de6baf8eb96b8c0bcec82b20c1150a9fe1d642078d32"
    sha256 cellar: :any,                 arm64_monterey: "095328787d6c477eb3f623edd0fc0484268861c2b5d045ecac04ac1423c60d06"
    sha256 cellar: :any,                 ventura:        "944f79a0a86431d42bff25c4e6383f1f44603694c617ff3be3a02793b9d0a0aa"
    sha256 cellar: :any,                 monterey:       "3016b74bbc4f622d82b3515d441284eb54820a34c8ba783241081aa43d13bdb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6bfade158b950a228ad0db6558615fe052c785e7f2b3b654fbd8b3d6d0a71311"
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
