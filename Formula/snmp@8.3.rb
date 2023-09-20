# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1bed209363900facb44674e76cf29fb681e48ed7.tar.gz?commit=1bed209363900facb44674e76cf29fb681e48ed7"
  version "8.3.0"
  sha256 "230c13505384d04072eadc06f607ec5fe31639c9deb7c908b7524535c738e24f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_monterey: "f1ea6384167b50ea56dfd45b58044997c49a5da78c847326ffbe2455e582e1fa"
    sha256 cellar: :any,                 arm64_big_sur:  "91a1b2385edd1825d4f057c9f9ecdd0fc837755256cee4ccb1b9e5e32025011a"
    sha256 cellar: :any,                 ventura:        "41cb3ca570edef3c698346e6ec5f92b02641ad258221b37255f6e497565cd112"
    sha256 cellar: :any,                 monterey:       "be0575b0531a025a8f6000bb8646ccd9112062a1e16509beccf735c910997504"
    sha256 cellar: :any,                 big_sur:        "3c2e2edc16c8e23bc5c2dc7c8695678c18d76c5062d3e231a717d5e0ecc7283f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "42bc4165da12a2f8aff7f352bc98fce56ff53bdb27f834703cffe4bc185229c5"
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
