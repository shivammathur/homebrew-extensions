# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dca4c0c085063632757e8f8d296e06aaff2159e9.tar.gz"
  version "7.1.33"
  sha256 "c16d623df64f5f4823b15880350923498ec0003af815a8c121a53b8755e14914"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "e00238647cdf770b0da1105669b5b613e8fcdff40e8dbe2aed306202cfef72c0"
    sha256 cellar: :any, arm64_tahoe:       "2fb12147ee3c9b8db65e60d7ed87fd3c8ed51abc21e3617ebb850257f468ad5d"
    sha256 cellar: :any, arm64_sequoia:     "89813b1918881ebcbb787758a7639d91b0094b1fe4610fb387d0eeae86b2abff"
    sha256 cellar: :any, arm64_linux:       "5b04f194f953e0e262fff70829612d06e77fe5186659bae95ef514c08ed83c00"
    sha256 cellar: :any, x86_64_linux:      "0498de37dfa511bde9b77c706cf6aceb8d61f2e931c3b5a41dd6af8b08b8ddb4"
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
