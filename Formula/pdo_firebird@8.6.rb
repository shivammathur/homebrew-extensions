# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_tahoe:   "37064dd3f5dea8587608e60297fddf8e69d4c317227d80a078a83a656d5de700"
    sha256 cellar: :any,                 arm64_sequoia: "4e45a402c8099bc3beff861a0946cba72fb471ddc7e560eb36ac35a63c916da2"
    sha256 cellar: :any,                 arm64_sonoma:  "40a9555f908bfd651e88dacadb2815dc9267c69defb0b64fdc040f385612b2da"
    sha256 cellar: :any,                 sonoma:        "a98992a6e232e8c782f288f798d37ea1beebb26e12a36cfd6a15092f61176346"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aa694bd8d5f7c09b0fac7d0893b226ef069f3bde6716cdbabe1c0f07576bb39b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4be94652a0eb6139c3d27b1f03196b62c34c6a54c8a0ebf6919bec2d70409a56"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ab043eefa4beac47f70036904f545a29c6253871.tar.gz?commit=ab043eefa4beac47f70036904f545a29c6253871"
  version "8.6.0"
  sha256 "faa0cffecf83d29fbade4add80001bd01d4211582bdf2438269533d0bb551d85"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
