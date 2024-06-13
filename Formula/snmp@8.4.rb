# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/18cfd94de402e1a843b316f15893f4a0d22a374e.tar.gz?commit=18cfd94de402e1a843b316f15893f4a0d22a374e"
  version "8.4.0"
  sha256 "be8383b40b09bf77f7d3feec08355ef5df24e5e83dfc5e82043cb6399a421b64"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 46
    sha256 cellar: :any,                 arm64_sonoma:   "42fedd63a23c9998eddef2014d51b2e7c2f8d6753f0e79f0f11348047c688b89"
    sha256 cellar: :any,                 arm64_ventura:  "5bcfc2b31896155dbd2a25b8b58288d8059cc19fd4f737d5911590a891979fea"
    sha256 cellar: :any,                 arm64_monterey: "b3f0c5ba23a6ba99d335e285a022be387a998d3ba233585a2ea6eb3917abde43"
    sha256 cellar: :any,                 ventura:        "ebc1af042b91ef9a04a0d93f2c818c9130ac555fad4e5a3f0c1b7a1d8eb4b918"
    sha256 cellar: :any,                 monterey:       "285b65cd20c668015ba2e78e6fb1670fa41ada9d9c30779cc3806e827f30b939"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a12d5eb9d7cc8ef6fd58f40ad697ddbab9637bd3de34c98458fb31b8876e83e4"
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
