# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/38cf52d8aa38fe2651d4da3aee9383a3e82bb138.tar.gz?commit=38cf52d8aa38fe2651d4da3aee9383a3e82bb138"
  version "8.3.0"
  sha256 "af947380f61efd4a3f6254f1de4f0f70924cbf1dfb394b949e56001d5eb5d1c6"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_monterey: "1ef4eaf9d967dd798c5dcccd7495cf263a68c70a338e29fc89417788383365fd"
    sha256 cellar: :any,                 arm64_big_sur:  "618debd0534bf5a797e84edcea22d5651b4ce2d32a9076863d53ca2bb9a8115a"
    sha256 cellar: :any,                 ventura:        "a580bc8b105b8feddbfd6689de6f2c2af68a5db6a891de597cc3e2a2f9ac5f6e"
    sha256 cellar: :any,                 monterey:       "5ee24fd4aba2fcd91ff8ef5662332d19d196caab5f5ebb2a34a9a6301d3dbf78"
    sha256 cellar: :any,                 big_sur:        "b8f632c8f968e2bf58989500164e500889143bd8e8fc5ec62d032cbec26e6f64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "603342397701cccc9ecf6a60036efa40bc868002840bca1ca000ecf58d616557"
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
