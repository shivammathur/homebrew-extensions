# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5ccfb6d3550d977f95b0c8338b2e5f99e05a31b9.tar.gz"
  version "7.3.33"
  sha256 "062d12fab7d94b517a64c89da2dae480a4ffc0af72e80342166fb6e1c105be76"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "8e30cd7b7626ccab16ff6f0739933ceb388c5224ba88b92d3be4fa11b16b4809"
    sha256 cellar: :any,                 arm64_ventura:  "f2dd4ab290d8a123b5e5e871e833a67e98e1e3f62e3b5b1dd9219d93eb7518e5"
    sha256 cellar: :any,                 arm64_monterey: "65e8e2c5f00cb1c7316596175dd1b45af42813bc923d15c4c405e226a15efb78"
    sha256 cellar: :any,                 ventura:        "a65b26fc6b47368c4c87826c550201865e393d9e0a3bea7b2f626b5f3e51b9c5"
    sha256 cellar: :any,                 monterey:       "b31c6e1eeab07cd00f8bc147844d68b18c4583f3fac0c9ea1c744b7c75b4e05f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "de510c7883faca8d4e794bc69b97326d85df8c9fff8a9ec49c10b25c96e6e2b5"
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
