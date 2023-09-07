# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/02fd32ea23999fb0ba3e8086c4f1619ef1647182.tar.gz"
  version "7.1.33"
  sha256 "9904d725293bd177096e549ce4f0c846bf2fcc62b4405c8fbf8af313478b0065"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "566f300a0f5e1194388153f9c3d789a736367c5c918cb4db310a38e9e836386d"
    sha256 cellar: :any,                 arm64_big_sur:  "69bbc0a5e0cfbc94e278efc37f22bc8abdda960d9d0f003b12882829d0ac4bd5"
    sha256 cellar: :any,                 ventura:        "84b1a0a783fad4632a73d1f2336a1d91510223d2e1b71ef771d59cb60da00f5f"
    sha256 cellar: :any,                 monterey:       "21129793c04b32e1e4394e6b59dbd6d1a080c51dd281f51cb8a6a60528887076"
    sha256 cellar: :any,                 big_sur:        "8429d66cd0b803b9cc4d8e7ed1c49043e44e65f89fbeb62206c54c064eac363b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4218e6a87f4b8db10f92e4bbea98dcb5c91b47e482d2e551dcbd13ac311e23c1"
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
