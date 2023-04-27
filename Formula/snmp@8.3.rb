# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7b4b40f06f39f1dc05fc4be8531fa3d582062488.tar.gz?commit=7b4b40f06f39f1dc05fc4be8531fa3d582062488"
  version "8.3.0"
  sha256 "780d0f93a5e2308ee3ae6a16a07773958678cccd71fd4ff0d2ce31c53178a4eb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_monterey: "65959f21fdf68af00c866d208b26377e96c20dbba8117c98d3d46d5d30a0c9fb"
    sha256 cellar: :any,                 arm64_big_sur:  "a8aed369d13339d486d72a8d8574ecd716ee78b082fb3708754eeb4c16e3845a"
    sha256 cellar: :any,                 ventura:        "050332e3c20367709394ce4ee1c9c6296c101c952dbaf2aa793e6b43b7c9e70a"
    sha256 cellar: :any,                 monterey:       "4c36278f93a6c5ec544d54d5debac35d73c04c81cb213ba7426c92c5bde9a869"
    sha256 cellar: :any,                 big_sur:        "551eb92913c16b897b011310d1042cdb1256ab20d1d8bcb190311d8c6deaf0bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "70b928bf3346b2c4465dbd2277fb4aa82e47c421f5b51dd086ef308f822261bd"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
