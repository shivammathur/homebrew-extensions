# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c6e5a57ed577f9ae3bb4b57a4b7bd09bf7f6a3e6.tar.gz"
  version "7.3.33"
  sha256 "047f6a5972a8ca6059dea14441000c196a766676f8a631891851d79331997da6"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "24def293f9f1560f0aacfeffd34809c26336f2a21dd6b7f19d0f3f2837318f1c"
    sha256 cellar: :any,                 arm64_big_sur:  "e52545abd269e3e2b350f3af81c620573dd97666c3b1990b225b147d50835ac4"
    sha256 cellar: :any,                 ventura:        "f4eeb88d3447e8c69b1be58047072dda6e5e3c494c945f7492b7cece05441328"
    sha256 cellar: :any,                 monterey:       "a7e6e3043f20c86a883e03e56f833f1475ba5d11bfbf60802a7b1f67493c6247"
    sha256 cellar: :any,                 big_sur:        "059b05dbd6f985c73ef2942fe063aa6f2965a111723f09c9a368a24f1ae9fe5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4745984a360770c30826767ca7476ebbce01ff0d44f5369618152abd5cc74b23"
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
