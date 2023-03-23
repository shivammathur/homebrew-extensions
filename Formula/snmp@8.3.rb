# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7b4c7374c3d3adfb690d951f5224ba0f27200364.tar.gz?commit=7b4c7374c3d3adfb690d951f5224ba0f27200364"
  version "8.3.0"
  sha256 "363582e78e39d12eb88dace8140ba3198094d2f15528ba8fc64d735ae79575a0"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "d2c0ef167553886cf1b76c37bd69044be272295ecac308f639aada6397ae3c88"
    sha256 cellar: :any,                 arm64_big_sur:  "459dea3a887855f27384b4056abb036195e4d7a595e245f690c0f2ea548c3b07"
    sha256 cellar: :any,                 monterey:       "c034698b363c13ac9ac9d16a74761841db3cf5016086270f3d0b2bfbc511e95e"
    sha256 cellar: :any,                 big_sur:        "f64e49a9a9b462f2caa15d677c9bd48e4d1fa37b66dcdf1c4da4e02c47fbf0f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49b8e5cf687fac6c933e34ff4bb3d431fb2217103a340280e68ac32b98f02ce7"
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
