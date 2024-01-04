# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/184152acf9810b92f4b0042c291a9701183ba412.tar.gz"
  version "7.1.33"
  sha256 "38b1bf128e03da65f3b61266d3e674ab941d4d4fb215a5ecc7cf114eea478900"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "d90e3dbebfe98bc0e549d78b0da12684983b553d61b04ad887b68f7364da2fe8"
    sha256 cellar: :any,                 arm64_ventura:  "f5657ea3dbd41619bb43503e15dcd28ce25cf3b8ec372a83d763cfbd19bd9cdd"
    sha256 cellar: :any,                 arm64_monterey: "d763a007fe833b89549369db10d6ce13f0620d407b0a0c7be69e2413e00435d0"
    sha256 cellar: :any,                 ventura:        "d79bc5f61e4bc49a3eef1681d6dbde86dad93208ea09c466260f0c425e90e1c4"
    sha256 cellar: :any,                 monterey:       "ea8a3040a415cf6655e45b606e78c0189b043f4475da8ba0b2f502ab25c5d03b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9bb892ecf04cb5abf9ba598693140b95951ca7346d1de2f2f5397827cd11e9a8"
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
