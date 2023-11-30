# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1e7c64bd4dc65e3361e3b86d90aac1b116d25f69.tar.gz?commit=1e7c64bd4dc65e3361e3b86d90aac1b116d25f69"
  version "8.4.0"
  sha256 "80067f8a333ae63d5104d76f8a328e994c851e639d17619b9322eb9ac0790afe"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sonoma:   "ea7f7161ab5bfe5e59eb64168b0ed72c89eae314abedf360c69cdf6cfbe57324"
    sha256 cellar: :any,                 arm64_ventura:  "96a2ec65fc5d6ee825fa2139c8f751ed27b699f604c8eaac59dfbcf7e91877dc"
    sha256 cellar: :any,                 arm64_monterey: "d7ce805b4260ac7f116ca2315efab6b85a4662f3fd408073b82fe0c83ff1adcf"
    sha256 cellar: :any,                 ventura:        "e9373bd4660b33114b4e3205a56a30586d714a6ae58a69a5ce5fb808ef7e9831"
    sha256 cellar: :any,                 monterey:       "7f5fb0e1bccf2efc9143c54aef8f2a48d078b880339a4115fed9735901e353cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc5234072464bbfc0da1cbff41ddce7317e01c7182489cbe7e290d294aaa4cc2"
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
