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
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "c53edbe65d4640285f5fc00ef3490c47e80d05f74287b23f60e5579988e8886b"
    sha256 cellar: :any, arm64_tahoe:       "e4631bca86fb44407a012a49c88c7ec0a2c523bc51211f1a6723c6827eac36d0"
    sha256 cellar: :any, arm64_sequoia:     "6bf6422ac3cba6b622dfdc21f9682910d0a143656606929ad1d1c89ff2605840"
    sha256 cellar: :any, arm64_linux:       "99ce1d42dce58bcc9739f98c9b23c3120e914e627a075af10e87c6bd82a76c16"
    sha256 cellar: :any, x86_64_linux:      "15d790761c49fbd27660878261c71c812809dc8abea0bcd8a86b0093c6cd4be3"
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
