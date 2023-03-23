# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7b4c7374c3d3adfb690d951f5224ba0f27200364.tar.gz?commit=7b4c7374c3d3adfb690d951f5224ba0f27200364"
  version "8.3.0"
  sha256 "363582e78e39d12eb88dace8140ba3198094d2f15528ba8fc64d735ae79575a0"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "d232558b7167b4f90c75855a5fdd8714d8ccd4df0a188e45846ee95dab1cb23e"
    sha256 cellar: :any,                 arm64_big_sur:  "66453cb0298588c492a3fc32ae60f528277b0ec4c5e7de89d33f39ad39c775ab"
    sha256 cellar: :any,                 monterey:       "958c5b68fc15985ee8eea33e7a238967965e07602ce95e862dea4671b99d6cd3"
    sha256 cellar: :any,                 big_sur:        "9f52537e1d0a58ecaa4330cbdecc97ee67195da703385092ceb9fa44bb3382b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b49f3134705dd8b80282c8bb6ad5b4ec32d3b41218b5a0288b5c2b06ba6d99b8"
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
