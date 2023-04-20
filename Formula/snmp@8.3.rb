# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/360e6f842c885f9e6018f603ba00ceb5cd78ef31.tar.gz?commit=360e6f842c885f9e6018f603ba00ceb5cd78ef31"
  version "8.3.0"
  sha256 "6ee93d0f0c4bb23a1f68a2a4e01da16f9c95fa8ab84ab6cba3e0b0cde25da371"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "20f94f8515ae643a53ee71cef746c2304e341e06a1453e8152f676ca2cb38e6f"
    sha256 cellar: :any,                 arm64_big_sur:  "1f46d492f74b6d31422cd0693a00ff8caac4797e08bc197300a0fd215a39d48c"
    sha256 cellar: :any,                 monterey:       "83a4f9965212f86f13821f9f8671f4e4355f3a52cfef8d6862dcae61a030d724"
    sha256 cellar: :any,                 big_sur:        "a1f99f8a1348e26ed16136b701d4409bf2e4da4085b7bbe6d09dbba5ec89cbaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9628f9c645c087b234281b32ae6134215c3526dba56127528905ab3b1a7793fc"
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
