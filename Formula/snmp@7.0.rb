# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e3a3b5ee45052f181393e7d9361895f169ab37a1.tar.gz"
  version "7.0.33"
  sha256 "2ce06a971c0029af7bec9247f2050e7f722eb28c094c639ea2d18acd780432ae"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "6b4d15caff107aa2c2bbddbb3ba8175893b9626bb1f4d2884157b69c82783cf5"
    sha256 cellar: :any, arm64_tahoe:       "734717c6f9223e7cce9104638ef1065d129a492a1c1043a47b6ef0d2ec1f85f1"
    sha256 cellar: :any, arm64_sequoia:     "d975cdec98fe885fd34ad650e429fae8c122d4ab7ff47c0508c94faa608d83b6"
    sha256 cellar: :any, arm64_linux:       "e0de75d0d7de8035c46c1a4679cb806baa2eda51efe5db8ec904904c21bf0e26"
    sha256 cellar: :any, x86_64_linux:      "924b47328cd9e9730e5230825703e30f92608f7a630b95b4379cf1caa71f5621"
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
