# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.35.tar.xz"
  sha256 "ff4630fbbbd94359134b7d3c223db59329905bdc4f5a9ef93d257b48e358619a"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "ca35a6237e10ed7c455dd8df3813e979e5dbbba6285ac90f5678aef427d199b6"
    sha256 cellar: :any, arm64_tahoe:       "f994170784c2a2c89e53bde14bc7bbfc5ee3ec5b0ddafe6f19783bed2ffb3767"
    sha256 cellar: :any, arm64_sequoia:     "0aa6171e3aafbd32f643b0bcaf8e7cd4cf816957471901e4a9ec9b61752faa0d"
    sha256 cellar: :any, arm64_linux:       "f5642e20e3e15c9a57d4226287f9b3b3e4fa85a05a7728c947a11d062973cd4e"
    sha256 cellar: :any, x86_64_linux:      "2c2f80065267bcd115b601dcc297202ac96b4ee4bb31f5ffe04b716e9c0297e5"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
