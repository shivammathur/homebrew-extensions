# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3b23de31db969c3c12060ff7c5ba363f65de6669.tar.gz?commit=3b23de31db969c3c12060ff7c5ba363f65de6669"
  version "8.5.0"
  sha256 "3b04abd3994da6e9f4b7ffc40770595f6e0908d88bd4009d54d1a43e0d7db9e4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "f9c46f0a1dedef5faa9b623486fddb5fc2879052c8ac515fbde2244b6b808ae7"
    sha256 cellar: :any,                 arm64_sonoma:  "75a7ffd3f0a4408744e9c662ee1fb439a783b3d4eb3db7ddfc05414e3cc89494"
    sha256 cellar: :any,                 arm64_ventura: "835bc8388f0e95224414b9f2cb334c8c8c7b2d0b6b9fc43c0ff269130562d371"
    sha256 cellar: :any,                 ventura:       "289b1b11f55bcee4af2b45f7b2cd69e0499cabcd1be9d36c9d73b3373eff12a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6257c9066865f633501352a39e1df8480abd771389c6e120d6660d419bc12782"
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
