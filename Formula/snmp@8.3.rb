# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b132b7ab7efb40628dedf2eae1cf7d6949684bcb.tar.gz?commit=b132b7ab7efb40628dedf2eae1cf7d6949684bcb"
  version "8.3.0"
  sha256 "6543ba2ba14df85657e0821edc232f000dc73d1330e8b7c2802d23d21c22f4af"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any,                 arm64_monterey: "47c30de377bb975157d77a8000a317ed478f4dd570ea9b48766db196ba1c2ccd"
    sha256 cellar: :any,                 arm64_big_sur:  "20407ab07d5fbb393c7cf8b35e013263da795c92ce631bb1c4aae36f40476c0a"
    sha256 cellar: :any,                 ventura:        "d2f120d3945be8ad32a7ea3301ffbefa95de7578d8fae716fe83cdc6ed2bef30"
    sha256 cellar: :any,                 monterey:       "ecc94653270b47537cca0e3981316285068e3a604bbf3ae5acea1fac8f5b2cd4"
    sha256 cellar: :any,                 big_sur:        "62877a225cfe46c98bd7b03c347d211331d9ae3518634bde1068afa99b5d4b7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb05f7ea6d596985ba444f0df69dbd8e0a4fa74f67e6aa460ee3ff488b403af3"
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
