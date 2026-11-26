# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b9324026a97a5255ffa24107c48c6e2a9c0a8b.tar.gz"
  version "7.2.34"
  sha256 "c68605c387149e04a20b193fcb93c8b65a859b7ab3f4b77b12339f83d6583319"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "6feb23e252d1966d2df33ea9d1a708ff0fbfc2ce81f075909abcfa06309135eb"
    sha256 cellar: :any, arm64_golden_gate: "d76c2d4ead61493176b7cd63b9a5f446807510a8ea1299e9c028292cdf03e3fb"
    sha256 cellar: :any, arm64_tahoe:       "d78d4e3bd654a179284010980c9641b3e7b0f62f64956a9a2ee60132850319dd"
    sha256 cellar: :any, arm64_sequoia:     "1df3fad5acd6abfc1e696a3a141b867bb454caf341e330662763d6f3e5f32ed9"
    sha256 cellar: :any, arm64_linux:       "a79fcc6283a13bd32320938c89c727ae2bba8ae8042a326d4d2b07e400101c44"
    sha256 cellar: :any, x86_64_linux:      "136b1e968ffb5c2391d26721e17f2723b541122721ad2db04fd5e662d1713d68"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
