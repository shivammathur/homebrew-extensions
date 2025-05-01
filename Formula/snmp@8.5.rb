# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/156d034d3da314925a77115538b55c7097c662cc.tar.gz?commit=156d034d3da314925a77115538b55c7097c662cc"
  version "8.5.0"
  sha256 "f8749e7fc8ada2d17d5e36bb33c4cc8b08b150472b620b2da2df518466d00752"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_sequoia: "e24bc78fdc980f4e62fe1c5996f33877d18b297397e83c65f1cdb97f73212115"
    sha256 cellar: :any,                 arm64_sonoma:  "eb71e60cb44ada4d8ac74d8b549eae7ab0917a5eb7e6c964a099ddd6297b8aa8"
    sha256 cellar: :any,                 arm64_ventura: "09bd02a3e9111396b5fe9c51e4f157f6c0651ba1621627a22d3fc6bcd2295423"
    sha256 cellar: :any,                 ventura:       "442c5481c7afb25188fea6bec1e0a7d414a0b48e1ac580c9a9ae9b7ca7703c43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3848719dacb544306e28a1c8641be531960a5859ba6bc79a6946dab768e16f00"
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
