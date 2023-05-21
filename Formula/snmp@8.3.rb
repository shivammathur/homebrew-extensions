# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/548e0615cdfa3f13e51c07e95cde0b20de21c877.tar.gz?commit=548e0615cdfa3f13e51c07e95cde0b20de21c877"
  version "8.3.0"
  sha256 "c44d2171c19d9076ee40ec2a51874750522c0c800635267ce3cd0b7c41d82f61"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_monterey: "c21ccda14fded04658990e1df5037b8c4150557ee310cbab17cf116279e48320"
    sha256 cellar: :any,                 arm64_big_sur:  "ee2ff3a14ee9f19db8d84c37ccc08836edc8ac32d71c4615fda99d1f31f56479"
    sha256 cellar: :any,                 ventura:        "78db56ca8d28105558539d57ad229b3a9f11b23dc5dd8dbde62babd287d79517"
    sha256 cellar: :any,                 monterey:       "ae2a741f88f1bf5152bd958743ca4d463367a6409113a07c562324889c4a88d4"
    sha256 cellar: :any,                 big_sur:        "f198b20323a06f0d55fca9e47d7c3429e8408913c42beb5f555d3e458ecc6868"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "89e6c3b72491d6ad16cf9a151b257de421e6275cf48d25c2280164ca0a1ac6ee"
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
