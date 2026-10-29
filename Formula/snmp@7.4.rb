# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9f3f6763497aa556d3fc56df7e66f44b8de49815.tar.gz"
  version "7.4.33"
  sha256 "cd3e5db449ebad253f678afd3421ffd108d6a3a6bd7ad1d05dc80988b96b015d"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "b3b950ff201cb4034ee03fbccc897d9b006762c33256ef85675ac901bd4d8c98"
    sha256 cellar: :any, arm64_tahoe:       "827627b0c669d8020176abc2517e3bb8633b38c158a32e172c9e1866cc59745f"
    sha256 cellar: :any, arm64_sequoia:     "0062ebb12f9ca54c690fca4646f6bdb8a5c4c37b78feac38926b2175302c13ad"
    sha256 cellar: :any, arm64_linux:       "c860eeb5ccacc983132161c5f6f74c5dd9d29db2320f4858a29a46f2e48e0211"
    sha256 cellar: :any, x86_64_linux:      "51fff86c6b38fc5a577de8f070ba84e26e8f5d53d533eeeae08f369c402c6719"
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
