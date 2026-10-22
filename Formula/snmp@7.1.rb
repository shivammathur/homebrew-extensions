# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/85accd17bbbe667724a4901e0b3eec4f5fabddaa.tar.gz"
  version "7.1.33"
  sha256 "f5c5326b49a1b2c0fb6049ba6e237e7ad3df4a3f75885509f591b71c15232f44"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "5c171a5143fb04d02029ed4e65813d88a8e11e3dc42e6b9ceeb505553e446d1c"
    sha256 cellar: :any, arm64_tahoe:       "b5190495d3d94f2d6fe4a53b5b1fc8180e3e8b6c9d4132e4d3178ef0b40d5393"
    sha256 cellar: :any, arm64_sequoia:     "26b8a55505d130dbed123776c02aedac19d745804d27866a61a575139cbe248c"
    sha256 cellar: :any, arm64_linux:       "f4c6098a10edac0b3faebc5e4706af047e978909d726adc4da5d4ccf5c1813f2"
    sha256 cellar: :any, x86_64_linux:      "00a63731ae315110f053b16f59d5de145e46a2fdd21da763783ffb93631cf5c1"
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
