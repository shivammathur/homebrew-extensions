# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/591bc8d42c53199ad7fe8298dce65701006a2abf.tar.gz"
  version "7.2.34"
  sha256 "6c45203a66c02bf2800b32120103e10575a0df964750ed1d2b1e7d06f7139b3e"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "b0051b592aa6e1912dad402d94daa3208faa8f4060184db491c44c7142477d87"
    sha256 cellar: :any, arm64_tahoe:       "afb9a6008472ed1397e0b450ed8e297ca70f9e16f943bc10790bfd2a346c0979"
    sha256 cellar: :any, arm64_sequoia:     "fdb1c206e8d52bae501c92ce2c74859b60e5b3c0e624be9c44fe4b8a511811d4"
    sha256 cellar: :any, arm64_linux:       "c27e7ef9bbe09d492eca541361faa4b21c6fa3607c67d3621ce7374d8ef5ab6b"
    sha256 cellar: :any, x86_64_linux:      "fdfecf8fdcadb66d5ca02e32d51baa965f7493c4bafaa514ec6ec03f76cdfd1a"
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
