# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/ab57e06d1e3481c1fbba19edc429e75634b6da88.tar.gz"
  version "7.1.33"
  sha256 "7ffa8f8d30b31d0632fa1ce26d32cc303607b2f88f5f86778ca366b10db05b5b"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "d24ceb11988b207409cfb89690c00d8c5d867f3d34a04192679ab70cb8ac5733"
    sha256 cellar: :any,                 arm64_sonoma:   "e9948a14d00cdb6e52abbc8c1977c24e85693206822d768f1b4d5c56486a3b04"
    sha256 cellar: :any,                 arm64_ventura:  "ab62061758d4d9ee58818b311a6f174fdb74449997f541a543abe8c21820d657"
    sha256 cellar: :any,                 arm64_monterey: "c37ea5ec9369272c5ee9d3b6f844df2511e7d446382579b4947da3e946cf477e"
    sha256 cellar: :any,                 ventura:        "a00e8f36bd482e26279298a85208b5f7489fd11faf7326d22de7c5fa2f42f114"
    sha256 cellar: :any,                 monterey:       "d4c2036cb40d36bef661a7c2dd64dd1c8bb050f5ec13f39592df4d8825859b2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f6d2dba0fcb0ccae2df578214aac4299eebac218b489ebba6c13316837e0d633"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
