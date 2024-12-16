# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0b2d7b889ff02945ff13e630654f861fd6d04851.tar.gz"
  version "7.1.33"
  sha256 "18aa3a76a05c2c9b3c8b1452d64b6b31bcb58bc163ce9927f1751f2a8cf81e23"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "d62b55d8ee549c12334c89d31c55c7923a0ef5d1e914b8a7d2466da1c2fea886"
    sha256 cellar: :any,                 arm64_sonoma:  "f6d4b8cd51209f8d4883a7983defc8d33fe059ede57c0cbaa0c6ddf3a2229cb6"
    sha256 cellar: :any,                 arm64_ventura: "5d58d7d62efb8139e521ee21129f1436a6cd0211aa6d1194e3e831e9e84f8ac2"
    sha256 cellar: :any,                 ventura:       "19b8e3e3808cbc530c3bfb3f47cdbcf2491b9ff57cd94c8921e2bd571fec70dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1687e8cf1b6954046498dc51dd74859b9996834e34ef208a5a35962a5922d262"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
