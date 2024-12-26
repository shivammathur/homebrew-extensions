# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/48b37fe3847cbccdc4bab2be55494698d5552faf.tar.gz?commit=48b37fe3847cbccdc4bab2be55494698d5552faf"
  version "8.5.0"
  sha256 "fbbcdf469f2f1f05e51a476f5e12df1dc5767a1385f6abbc58d29f11469a725c"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sequoia: "dea6f2fddf7a41b9aec7247e78267931b503d465c7e2a51f904200a9b26d819d"
    sha256 cellar: :any,                 arm64_sonoma:  "e63ec0a03a1cab3ecefd28c6acfced92196db3e0f16ba3d2f914cd7c456794d9"
    sha256 cellar: :any,                 arm64_ventura: "7889afe2954718b4f434eb989ba86c3476ee790e1002aff43d440bba0cccee41"
    sha256 cellar: :any,                 ventura:       "f8dbcd9ea00132982118375b8e193dbd62c7113abb2eb1104e8077808edb6863"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae78944be004943c031cebe9167bbc936ed731147a85643f5be3f7a46bfe0b2f"
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
