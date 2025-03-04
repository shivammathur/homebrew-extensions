# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1ae2c871d0b69f8cb460eff0c69191a0bbb1f530.tar.gz?commit=1ae2c871d0b69f8cb460eff0c69191a0bbb1f530"
  version "8.5.0"
  sha256 "9a05794fd58d1db96c3af5d4a12e4d4027155201e330f59a974e8cbdc4d55d99"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "80cc1923722f36dbe19f5177ea6f21be64494f5bf8ed7bca34fae263dd6510ff"
    sha256 cellar: :any,                 arm64_sonoma:  "10d432a714967c186459e4454f06058879be0b53044ea2e2f9c5ffd881a93ba1"
    sha256 cellar: :any,                 arm64_ventura: "884c190e38720ef2a4bf82fa383a1ec551a0ec76a0c2a3d92d2c0a4f02b7bc46"
    sha256 cellar: :any,                 ventura:       "038f8c68bb6e62602f8bde8a60e8fbf6882622e4049d546a7c8b5fb18044da9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62856b8ccbeedaa7934470fca3d84609ef44a7daf8c2f798efe848599dd6cb95"
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
