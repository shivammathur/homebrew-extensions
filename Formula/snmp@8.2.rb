# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.30.tar.xz"
  sha256 "bc90523e17af4db46157e75d0c9ef0b9d0030b0514e62c26ba7b513b8c4eb015"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "f2cd0cca7e7403e6e469e6ea1680b1bd922eab6c7b9f799185c6ccfaec32da71"
    sha256 cellar: :any, arm64_tahoe:       "02fdfab9b45ad91d1db620c78ab905b321a7f7203edbd33371d18fa390904345"
    sha256 cellar: :any, arm64_sequoia:     "7cc25487215dc15291eeea1e93c6d7b4bf552795072d2ae137fa2aba54f36ac8"
    sha256 cellar: :any, arm64_linux:       "16d4d60fa2460e3ad622e25b79904a4bd2f6b918e2e6f40f146c7636a1ebaa14"
    sha256 cellar: :any, x86_64_linux:      "ce2f74dd22830055d4c4980575b392d8f427bf229561e52a7f4a470a97363103"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
