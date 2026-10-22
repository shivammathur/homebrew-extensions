# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5f8af80e6bdfe5d80880abccc4e7cb415c26ca42.tar.gz"
  sha256 "75a276a0a65cb6ad4dfab2db6fa0719601b593bfa99fd1936105952465e4e111"
  version "8.0.30"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "030088314585603b2f606f9d8ad2c8166acd367fff5ac270b08435ca0fd9e8ba"
    sha256 cellar: :any, arm64_tahoe:       "e16cf4a30a89b964f5703ef7d1789e3bd4d5b97e9e9a024f78efdcfc7ce4cff2"
    sha256 cellar: :any, arm64_sequoia:     "4fed35e38cc9442b4024d1c26d4a822c433854e19f05905626c98b8d7d872a98"
    sha256 cellar: :any, arm64_linux:       "50b08b22d277471c0ae8f31bb20b475828648877febf4f1860992527b2767bbf"
    sha256 cellar: :any, x86_64_linux:      "4557e7b668f91369c287af6400f041f657a0a3213526c3787877611c2b486f59"
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
