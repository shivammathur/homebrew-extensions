# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5f5f0c7929137acd2cb483a4b288b41fb0cb0fbb.tar.gz"
  version "7.4.33"
  sha256 "7c9de3f869a5ccae677b6a83582d5e5d0c825af22096c4e924c10abe118315f4"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "c39723c726eab6f3589a2d0676b457e87bb2d02a4bdb6c917a902811471447ef"
    sha256 cellar: :any,                 arm64_ventura:  "21c41478049ee647564fcae321d9e0e892bf33cd4f5f6e06ea2e236cfae0c44b"
    sha256 cellar: :any,                 arm64_monterey: "8e4a433806e4eba041947559ec2f5fa4595a3adb4285475091f23936465a2bdb"
    sha256 cellar: :any,                 ventura:        "9a74d893cd288bdd5f1a05693a9b91b0025369a327ae9d1d1da0135d4db4276d"
    sha256 cellar: :any,                 monterey:       "776ea08d9688be92f2eb197a377dd6857b1ac50d079c9fa2bae21fda85310528"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "051c0f62feb8f2a602680ccfee294d7cb86c41598aa736898152b92052853cd4"
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
