# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2d545dd1b765e062205cfab1c1594b3f70e163ef.tar.gz?commit=2d545dd1b765e062205cfab1c1594b3f70e163ef"
  version "8.5.0"
  sha256 "ff9880e2a90998ee1e1e501dede3970303b9fcb9cb52862f1ffcb93533fac848"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 42
    sha256 cellar: :any,                 arm64_sequoia: "01dfc448f4f69286778fe75d5e16266eb3dc3991081abbfd1439c83f9d4156bf"
    sha256 cellar: :any,                 arm64_sonoma:  "4a9fb5746e25830f81aba89d981872e8ffd5d7da858db3b56cd2b137d09600e9"
    sha256 cellar: :any,                 arm64_ventura: "eb6df9296c38a56b98d9602f0a91b0de0321bd41c2efd150565bbff7a10c5ca5"
    sha256 cellar: :any,                 ventura:       "47fd9e698216c53cf253c66dcae761e2e46d3749348b6d89d80f63938fb5f332"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4e743950ba84374c86af0d835387dc10312f0d5ab70312900559a18251bb736d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3663ba2d4c220c740f35aeeb227dcada2ef594f48b658f5e0334fc104750846"
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
