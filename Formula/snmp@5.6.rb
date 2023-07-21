# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7b23b9111203a96db10f8da71dccb2285d872d8c.tar.gz"
  version "5.6.40"
  sha256 "f63340f5ed259c1ed1efcc2c935dee875c77f2ffb778bc11ca2572e099108451"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "0e982a0330c662d99eae1268c1f02da1cbbe704c9a84160e89b52bead9220c90"
    sha256 cellar: :any,                 arm64_big_sur:  "e02c682de781908dbdd0dc200f728931a76f76301e7b6eacaa4d2b8f39d8a9cd"
    sha256 cellar: :any,                 ventura:        "cd32857da203b2c935adbe27b3f164a81158845810bd151998301017971843df"
    sha256 cellar: :any,                 monterey:       "6f4aa091e23ed6bf88a0160a168aa1f98b94d03809652e42488fe282cd4b9855"
    sha256 cellar: :any,                 big_sur:        "e4c97f30f3c3a949ca4813bc7b473df6899f515141a8fb2630a2d5b2a506879f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b700858c3150d91ba94d18acb29c8eba6c3d6e8f2186449ce1ff7940b5be418"
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
