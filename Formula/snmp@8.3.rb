# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/91fd5641cde138b8894a48c921929b6e4abd5c97.tar.gz?commit=91fd5641cde138b8894a48c921929b6e4abd5c97"
  version "8.3.0"
  sha256 "691d6fd4c53adb5ad943b8c711a96efd67ceaef80dbafc91260eb3e4b64dcf84"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_monterey: "c3a2d837f9fa41bd6f9edccbbda98235332108e18ad6cd19331fbc75cf8c2dc5"
    sha256 cellar: :any,                 arm64_big_sur:  "3b2ecc67ea9c0146d126b98631ad802ae0a334d0d2e94621b33811aa62b7c030"
    sha256 cellar: :any,                 ventura:        "0a1f18efed8bc5c54a8a3ec1fada8395335fb55fab857fa7bc8b4309d0cb16a5"
    sha256 cellar: :any,                 monterey:       "7f8f82341fab59311ace33e4ec78999f290e3d568322c8eae835a002c5936fc4"
    sha256 cellar: :any,                 big_sur:        "23b4fcb1a0ea7be96209cfa32f79dc6dfe6e6c89f0ca728ed4d2d48125b69c39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "21a74684e5074216718ad37fa68484a9b11b4efa5c1f451320738c1e49b9b97d"
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
