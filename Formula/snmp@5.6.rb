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
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia: "966d90880ec192084d86059b1dc34082cb588904500f3e68ec2a66eef04ad20a"
    sha256 cellar: :any,                 arm64_sonoma:  "a05a7a0c612a10c5d0723ce215217442d1e7ea6a3d7db4047101a8e3ab7b55a4"
    sha256 cellar: :any,                 arm64_ventura: "6f797c16ac1d4f86f62af881c2f06d7f689a8ff98ca38e64b6e3c1ebd201defb"
    sha256 cellar: :any,                 ventura:       "0afa7dafe9a44425b1c64a990fa29c6988949ebe1c0bce1e4298678a6e21e36c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b015c335846e8919b67d51d6c8248363d5c278f0b0411cb4d11c6dfbaed5d471"
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
