# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/67a075e9b509891ae7b95e8ff48e73c16f63a19d.tar.gz"
  version "7.0.33"
  sha256 "29b56e2126d94f5f8fa848194fb4073f33c30ce1f484c94dd52f77de668fe850"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "e11f188eb8d8a5b1f6e5c0736006f201f63bd724dba9d40d594fe44a7e3ff4da"
    sha256 cellar: :any, arm64_tahoe:       "5dc68f37ede7ee0d837fb8d5369cbaf1dfa44673c1ea5ea9ca228732535e86cc"
    sha256 cellar: :any, arm64_sequoia:     "9a6110bbed58bea2121ff6c52868d3179702e5266dc9abcde1d2a5f5d752b436"
    sha256 cellar: :any, arm64_linux:       "80ffb0e04f32d6ca00064556d267a87c3bda3548f6d6e540c8db926369ec4942"
    sha256 cellar: :any, x86_64_linux:      "2258ca0097f10385cf684ab22758308eb6a6b59f3ab0129caa90779eded71385"
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
