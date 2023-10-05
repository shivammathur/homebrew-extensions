# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a2d25afa4a643ab44339a7858240933b19dbfafe.tar.gz?commit=a2d25afa4a643ab44339a7858240933b19dbfafe"
  version "8.3.0"
  sha256 "0a2ed49c73ced453c2364f01642339a071cfe1ccc2d9dac873de1227ef8b8aa8"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_sonoma:   "19a65e15a7b80a346fc03052c3b11d01d90d5ae6a3794738b358957288cabe85"
    sha256 cellar: :any,                 arm64_ventura:  "7394af1991c0eeca8fa8c934f59a7efba899d98f354a44a46b8ee1f51aec399a"
    sha256 cellar: :any,                 arm64_monterey: "26cd5bc4bbfb4870293280e274696491ffe690293bdd2522d35c4f52467b218e"
    sha256 cellar: :any,                 ventura:        "82e338d642816c000c62aa987113423326c012e64e1b04f621b3c2c60baf51ef"
    sha256 cellar: :any,                 monterey:       "94006f4aac05e28442f8de5973e31f0973d3e1ecd144f0b531c3828dde1efc22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6979f3c642aebb54640082cc900cb428ff3c77603fb3b9024e951d1b3eb9ee67"
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
