# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.28.tar.xz"
  sha256 "95d0b2e9466108fd750dab5c30a09e5c67f5ad2cb3b1ffb3625a038a755ad080"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "265895f3d1007fa18042665acf34137b74facbeb38a0ecde4513e9a2122b62cd"
    sha256 cellar: :any,                 arm64_ventura:  "9142dc9e60b078162be12e3bec4977c4b1e6cf23c24baf4842dcc3735a64c169"
    sha256 cellar: :any,                 arm64_monterey: "d01ca5999f6436c22dcc1f574f6937067d8a79d935f7a8cae29bcdbdde0d7331"
    sha256 cellar: :any,                 ventura:        "67f6139324bd924241e2efb4d1973942ef1411bcbe1c4d3a77c6dbe6c0dad477"
    sha256 cellar: :any,                 monterey:       "c5ea2341fdadfdd8c94cd558948c2bb82a91068d076c13c9a7409d7b707096ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5dc1287028843511cad2ef5a5443de5303e01e894b0975d5ac8f0563b727be0d"
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
