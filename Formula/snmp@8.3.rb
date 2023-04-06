# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c796ce5713f21a3de77e710f4028c62f45bc0fff.tar.gz?commit=c796ce5713f21a3de77e710f4028c62f45bc0fff"
  version "8.3.0"
  sha256 "a18ab59f65fe42870f2085fb9ef293bf03a39e7f7021c08f710503e287bbd885"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "aef24afb65db8d5e4fa7fee5e1d8281a80a2cfe13de52ecd6eac09c50c4959d4"
    sha256 cellar: :any,                 arm64_big_sur:  "b3ffd707bd968c14cee635c362702428684cd80ef8c85cfd805f9b44ada28715"
    sha256 cellar: :any,                 monterey:       "179f3bb50e50037ef18d493361c43f3b0e27a53549d632bd2860d2862e2632e8"
    sha256 cellar: :any,                 big_sur:        "ca87aa48c93266c363b3efea26cb1d24c6a2e05ff0c41bc72b51ecba6971b249"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c646fde6d3abe74b85dea25aabad04f41b5328c515f85cd5c05509ad3b9e57fe"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
