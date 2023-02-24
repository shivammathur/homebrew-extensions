# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8995f602584a5267999f51cbc73f8c03eee36074.tar.gz?commit=8995f602584a5267999f51cbc73f8c03eee36074"
  version "8.3.0"
  sha256 "f20f5b318b780fc8436e10988dc407e4dda61220f4902ae5e90e3a1178b6a52d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b71e41f5a39694cf58d7fceaa2a8578d509ca2a192e9870d2003e2c64efeb0c7"
    sha256 cellar: :any,                 arm64_big_sur:  "b8d16c81bccd601ea0db7af8d5af694166eef1decb92c06a187227ec70bb29dd"
    sha256 cellar: :any,                 monterey:       "55ff128ed417628548c9e43fbb85768aec0fc04fa7089570a8974cb4ce8f92fe"
    sha256 cellar: :any,                 big_sur:        "fe485a74691c9155df5c3a35b8095af5aee31648ffa83f714111567b11b9de4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "df535e6746025e4e3366d1fddf7c604f4484308fc73656a213626866ce52a099"
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
