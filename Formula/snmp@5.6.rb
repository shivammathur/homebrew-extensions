# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/241845d24ddbbccddc9be4006c103d9ddaf3b724.tar.gz"
  version "5.6.40"
  sha256 "836bc6985113313d2a9cfc14864f9506b0c752c24cc9bf0a66454e890921b9d5"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "ca6a067692b156d06d64a8500d71b0bafbf0cd7f69df289f6e7427584d908657"
    sha256 cellar: :any, arm64_tahoe:       "7fa5a6e32f1ccb24ac063e176859f2db170898496976876666dac0c568cd70f5"
    sha256 cellar: :any, arm64_sequoia:     "94f59f8aa02c3cd4ffb773a1e223d145cb742133e2491565b722a1d3f0683186"
    sha256 cellar: :any, arm64_linux:       "9b55ac239c62d90d6a47a25e0cd581a397a1c41f5a24420c36cd5f097a1f29a8"
    sha256 cellar: :any, x86_64_linux:      "3e7ca63a9742b0f33ebe80c3d6da32c97ecc924bbe9a73b1df4561cc5f0990c5"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
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
