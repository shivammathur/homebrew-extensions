# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/190a0202b4601d3066088ba913c2f1bda921ad8c.tar.gz"
  sha256 "3b70dac41c775c41913ff3a13c77beeaee375b995f41940e62ace648119c4622"
  version "8.0.30"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "99a347a65dfc37316ef5f8be41b6c00ef9d45aca540c33090c3c345640c5acd8"
    sha256 cellar: :any, arm64_tahoe:       "3a918ef1b1bb7d83adb282ee3ac93bdfbb05779e03c54f1fe44382fe561ebfc6"
    sha256 cellar: :any, arm64_sequoia:     "e31260ad185214d77b07e0b5943469ffc6836dc6ab6c930e36423435e4616526"
    sha256 cellar: :any, arm64_linux:       "31248080ac705a3f44d1066d8b511dbd79e8708becc29b3dd1e1ac5c6e111d75"
    sha256 cellar: :any, x86_64_linux:      "690352e90161d057064eec8dca798df145afbeb22cce7521185b217bb073ab22"
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
