# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1bed209363900facb44674e76cf29fb681e48ed7.tar.gz?commit=1bed209363900facb44674e76cf29fb681e48ed7"
  version "8.3.0"
  sha256 "230c13505384d04072eadc06f607ec5fe31639c9deb7c908b7524535c738e24f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_monterey: "c2397d518792852fedeac2d855ed2c63a6c660632bfbc48d7d917941a2d5eeff"
    sha256 cellar: :any,                 arm64_big_sur:  "c8d09d912c824cf74274bb70c787f385821d60d1e28e954073469862e101fd64"
    sha256 cellar: :any,                 ventura:        "7e3038df620b00aaddae2915097ca56e87e6618c61bb0aabc03edf02cca34aa1"
    sha256 cellar: :any,                 monterey:       "9256f85a542e15dc3edb88ecd5366860625309c77330c2dbecbcfbbe2a93e54f"
    sha256 cellar: :any,                 big_sur:        "727d3568ec86e72772423956cbb26d493dfd60a1a41cf4364cf3454d942b6a7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a1b931fd3af32b0402417a12e5d0f424024f3d51accb9304be93b56281e5ced5"
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
