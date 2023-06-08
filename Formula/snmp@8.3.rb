# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ca1905116bb25ffda5509078563f673644a1656d.tar.gz?commit=ca1905116bb25ffda5509078563f673644a1656d"
  version "8.3.0"
  sha256 "4acfeda438eb527da8d5ce6716822dd099182bbb55c85c3760a664dca7a0b0f1"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_monterey: "548e0abdc7a84779dc7b36b87bd34fa34c70960868b31663fb90dd219c7d9fcd"
    sha256 cellar: :any,                 arm64_big_sur:  "9fa8c02b89317ecefa4cc7ecd28370ac76be9ec2d86a532045cc15df44556110"
    sha256 cellar: :any,                 ventura:        "5e181f59d2d2a1b1698128d9af7462d659f73f6417ddf232c4d3b5ddc6203041"
    sha256 cellar: :any,                 monterey:       "535756b771deab63ca34ffb66de928baf138956c4ebe1b03d6eb7996ef31064e"
    sha256 cellar: :any,                 big_sur:        "ba963f6f2225c2ae6d0b39033327b1e37ad61cf49a82f285decdab8eb565151b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "62af8aa71221af6f8b902233f70def2e8c2bdf6f481db5138c97fafe37de2af4"
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
