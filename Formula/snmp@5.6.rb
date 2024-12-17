# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/8e9bde45d8f4cfcf72f5a730f4fccf907eb5c35b.tar.gz"
  version "5.6.40"
  sha256 "e6dc16ae13225a59b718ffd44481f67d2df8bdef2af625f19229a1c08cf52303"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "32345b129e9ececf4ce3f71a29a893b1d834438f3236f74118d25614f49e2698"
    sha256 cellar: :any,                 arm64_sonoma:  "0ca2cf21543016bdb974b4169e5f13cd0791f201e25513fb445d6b749db6e56e"
    sha256 cellar: :any,                 arm64_ventura: "7987956cb829703edd7d86fc5726ec82e2aef9c7a4e9a0f85977a38561b764e6"
    sha256 cellar: :any,                 ventura:       "362d9d0f49d92faa0703a6045718b9229d619b072660fb98d49e67ceb7ae4a81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "97f2758d97368cae5045b2dd5774397f2e99024201c8db63427953c38eebfd10"
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
