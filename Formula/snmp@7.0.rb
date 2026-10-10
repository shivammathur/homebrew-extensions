# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/da64b9b864bf43d9023d6d1d6d5b582800d72c9e.tar.gz"
  version "7.0.33"
  sha256 "c412fdeac66cb816f3f3fa5a7a6755daf3f37521d997fca771ecd40f61b22cc3"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "0ef9a8a6caa6175f19c3e0e89da64a7355b59fb2dd318f4d33b71760d0d13fa4"
    sha256 cellar: :any, arm64_tahoe:       "548b1ad08c9a3fb2b3e88be7366e2d5d7817487228ff95fc21210289b5717f87"
    sha256 cellar: :any, arm64_sequoia:     "d4538d5f7a45837f85193e6153ed9e8c2dd870f16b71bd857367e40d6fbcc069"
    sha256 cellar: :any, arm64_linux:       "4f7fbacf27dbc8d8a7dba941f31540333ede6416cc4808fa325de5883c12812a"
    sha256 cellar: :any, x86_64_linux:      "942308d4c3b92eeb4543a33e00c1b84497cb4fd207760d0438a33d05dae6376b"
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
