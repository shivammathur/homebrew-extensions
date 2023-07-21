# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f12d05c0fdf5c88c94d8d54fa1f925aae6e302a6.tar.gz"
  version "7.1.33"
  sha256 "3153fd11bee1ff291c9367c9544f12b3df2070bba97420a12c835505ff7000ea"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "82c754528aaba928fbfc84b462b12c2f190aa1007ce2c47a46113f14730cf0c2"
    sha256 cellar: :any,                 arm64_big_sur:  "fd7cc9fb32d2a9a5122df199a7e8be94ff07b7a288cf86dda3cf963d72b50862"
    sha256 cellar: :any,                 ventura:        "888fb761120e18e95d8cfe73b1dc90d2b549080ed6722ce67ad28d4f287831c2"
    sha256 cellar: :any,                 monterey:       "9e73c2a8b283f7850ecf806f639f306b97cddfd5a5826a3cf87feedc551882ff"
    sha256 cellar: :any,                 big_sur:        "959b0ca414ea82ee91670c2fed71c62262f50651ef6a79a92715f71f17e4c2f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a35a7aca37a2675050fd4ede53fd506c2cbb82d50974a08105c5a0f94597b34c"
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
