# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/34456d7558a6a1741fab48074c0c42d89b4834ac.tar.gz"
  version "7.3.33"
  sha256 "14d7086d3098273da345e1917ca44b6aee8f2f12db230ed09e03e5bfeaf5fab4"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "632acf4c09f864aa3d4f44e8c37f05262f00e14f8e96c11d454899ca03b96da1"
    sha256 cellar: :any, arm64_tahoe:       "61a35e8c5b817075d9c86f00d62c7965eba1cb8c8390e7d0b66edd70434225d4"
    sha256 cellar: :any, arm64_sequoia:     "e0f5b077073f52e9e9b714c6b50ecc01df1379e7cb9f7455cc46cc50b82a1ac6"
    sha256 cellar: :any, arm64_linux:       "edc1e88596ad7b359f58d01ebe427558e996fb2179099fe9c56b60473bbfbaf4"
    sha256 cellar: :any, x86_64_linux:      "19f1a97bb0741b18e19bbb1b4f629376d766040683551e12706aa07d4ad6bd2c"
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
