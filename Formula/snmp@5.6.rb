# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/25fce28ca29c7bea677695e50c5ed52139122d20.tar.gz"
  version "5.6.40"
  sha256 "779061ac26e633a1fd52317531a8473bf89872408540ee708d8e3fa285a89538"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "d4cfc3110188e14017ad816fa4849f9ac3f41a3939ec11ce6c0f8566fff55f53"
    sha256 cellar: :any, arm64_tahoe:       "3b5ce9dafb2f43dfeec5fda0285cbbdf2ca7f1747095c6f0be8ffeb43ada130b"
    sha256 cellar: :any, arm64_sequoia:     "1b60abccb044399d026c372e5e39f855d86050e13f243b569c9ddeca41147348"
    sha256 cellar: :any, arm64_linux:       "f1dddaa0e558121d1d01a0535f28bd8cb639f3b5c47e89fba36b73dc8b126aca"
    sha256 cellar: :any, x86_64_linux:      "d7646d5390c6b5ecf0061279b332877618fb993a2ff696d6cb5fb98f678e9331"
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
