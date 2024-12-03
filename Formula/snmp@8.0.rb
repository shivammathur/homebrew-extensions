# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e62bf3dbf92627e79283013f6e83f7a4e5ab3e6f.tar.gz"
  sha256 "0ade4ad72b41f3e1c05e001dd3cccb52800eac770f5bbb9472674bc1fa90920d"
  version "8.0.30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "c0abbe65a3ca23e8abea316b5cf0efa1c92a9106e2e69b2cafea48acf7cdf14c"
    sha256 cellar: :any,                 arm64_sonoma:   "a135efd585243967ec3881b9037a9e43ce9941f167fc42a1873c09d959b44e33"
    sha256 cellar: :any,                 arm64_ventura:  "9db5af2f754bc16894498e88e7065be99e45073d88360a98c8d67788fe528db8"
    sha256 cellar: :any,                 arm64_monterey: "151e72b01ece249ab118c3bc5f1b585869c28f6b6e37b963fcda4e10e128c280"
    sha256 cellar: :any,                 ventura:        "d3550dd4ccfecd9ba1985b94969f3101f2cf82e4cc19f23729f8b2e008bccb66"
    sha256 cellar: :any,                 monterey:       "5b1b376a23179b709bdcad4f865108d58b1272f939c5c0f471f2562110cc785d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f75027a455de23acb09c803761f15a6d4df486e4a523489f9ad89a48f171a5e2"
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
