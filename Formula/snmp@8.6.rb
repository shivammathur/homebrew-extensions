# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT86 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e2da92b15c71d2a97420ca590fa6579f049d008a.tar.gz?commit=e2da92b15c71d2a97420ca590fa6579f049d008a"
  version "8.5.0"
  sha256 "322352048aa6cf9ed238a18a149461cce9b27111fd8cc82d3da7b1c2e9603537"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_tahoe:   "fca64e6a7b7f56500a843e0f6a582154ea3f2a43d53a26d227f55c5887c3b963"
    sha256 cellar: :any,                 arm64_sequoia: "fb0ad1a2d67202cf772e6eb1cee60dd65cb5af08e79f0bc6b86c96eb30846d70"
    sha256 cellar: :any,                 arm64_sonoma:  "e0faceca8f40786dca1e8e04468e75e0ef70b1ecd98004196290e285f70579e4"
    sha256 cellar: :any,                 sonoma:        "b54bfded75d2dd14ac39c0cfe54a1e91d4064a1b02581afef9344001bde85904"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d98ce2a20680739322cff5fa04711d2b5d513545d386c3ca605f0d5784c86411"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9d5c5c05d5c77283d0cfd09145c47dfd8800726a39ca2a38bfc8125d0abbd5f"
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
