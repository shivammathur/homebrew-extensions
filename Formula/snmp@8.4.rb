# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5d980694564c11e08e8f14fdb325265ce9d33d60.tar.gz?commit=5d980694564c11e08e8f14fdb325265ce9d33d60"
  version "8.4.0"
  sha256 "9efd2ff1f0b424e0ed92559bb68864e830e1327182e421928c3ce2cfdb1b08a0"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sonoma:   "93386afee94c3948e88e168892c6abb1e1cfc18683e2d1b1b64b19ecc107d8ad"
    sha256 cellar: :any,                 arm64_ventura:  "dc2d4789c37ae27414410713d547b000e18bc78ae4b1355636ad7a92fabbe466"
    sha256 cellar: :any,                 arm64_monterey: "234d77b8a5c6c57df8716a6c098f98d3ebcded5c6d90822cf0d1a74378aae659"
    sha256 cellar: :any,                 ventura:        "0e7d66ca352914af01e225ff58551a042479aea2c70b1be83f68e8bb1ffa4363"
    sha256 cellar: :any,                 monterey:       "b98fbc365393014299823cc7f4b5af6d275a6816cb6fa2a2a76a75efac67132f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "134824b4d6a129e002d26c6a2421d031c47a11eb5869aa5fce49a2f4f7b35778"
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
