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
    rebuild 22
    sha256 cellar: :any,                 arm64_sequoia: "a62c7c5ee1f005e6c94a5a0737f057f875a1a4ea204bd5f015cdc9fa1f29eca0"
    sha256 cellar: :any,                 arm64_sonoma:  "0831083232b446db20d8daa809e45b0846726d9ee722c2a513f25fed18c5cdb1"
    sha256 cellar: :any,                 arm64_ventura: "a0eb40f10c58377f9bdaddecfdbcd7f48bbf69d79d2667d051cfe367c01f35e2"
    sha256 cellar: :any,                 ventura:       "3ac790699a6816d8e633c928dd7e3c4287ef26efdae666cd147206b92d0d9257"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03d3ed746340f97d848030171394f43804220645bd19b55b9b761a278c5ce91c"
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
