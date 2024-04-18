# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/fd96daa9aae7a1c43be03fb261bc54f6d3692e06.tar.gz"
  version "7.2.34"
  sha256 "9428386bdcfc4b3e64360dcd906368ec457a909775913605d8f6514c3ae5b291"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "b83367ab5cf1d36ca4c8eeeba20a9eb6d3883964f9b817f8a64bbcd53ba99fe6"
    sha256 cellar: :any,                 arm64_ventura:  "f30edd6361de8676ac46647f2d94a56121c08b816e21c2e66dda9efe73506852"
    sha256 cellar: :any,                 arm64_monterey: "0ecea8b1a7cce770a8dac62414c73c1e06137208b353f70e5400088e57463fc2"
    sha256 cellar: :any,                 ventura:        "bf8ff42a842b8ee3525066c32ed5482bd934fa6810d59afa46d3e25495556047"
    sha256 cellar: :any,                 monterey:       "83a78f93c82aa7a0af6d745bbb591b8f6bfc1106a98c567e903d6bc3d5f384a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cd8a6a422cea57cab0a58f58a5b1d6f5796e0a7e81ff7c47aaa125a0c1ff9bdd"
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
