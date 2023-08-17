# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7e4ca2e8d9fe9131eb24e29a8a508059b95018f9.tar.gz?commit=7e4ca2e8d9fe9131eb24e29a8a508059b95018f9"
  version "8.3.0"
  sha256 "4cf73ec4385ab0914416beb130e693cff6db92413fe288898f920c0f57346b24"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "e30355560d1c7531b1524fd775152ad38b968f6a2a8faa82fe92f2e77f5c10ad"
    sha256 cellar: :any,                 arm64_big_sur:  "58a18ff030a744b975ba8932fbbdd7335047a8f591ff65bbf4ce1a2ed665a9f5"
    sha256 cellar: :any,                 ventura:        "a33a337e0425ac3ff498187f69f3a4b7618ad95a820edb44273d5a4fe73cd1f1"
    sha256 cellar: :any,                 monterey:       "c1d0ce6e3523b172c5d4a52a70e756f514db91811815f6feb5c1f7cd177b3ae9"
    sha256 cellar: :any,                 big_sur:        "4a9b1495025730930a4b799f85b866d5a3c9aac0fb6adb35f029657175a8c31b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "521a0ad7fe0592daa0eb5eeb6a4867929eff7c7ea208c1436b04c1f98d418d08"
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
