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
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "7d4f513debc54818e9caf88763c9bf3e58e582e83824a62cbb62b04a88e9c86e"
    sha256 cellar: :any, arm64_tahoe:       "24cc9cedb40721788f024296866cb582e9bfc50c8f8006b318ce6429351a6723"
    sha256 cellar: :any, arm64_sequoia:     "c91bd98515c58ea54c1d755975e50a04eb9c4e1e54fdce1e474ccbf143aaf849"
    sha256 cellar: :any, arm64_linux:       "dc6662ed4df08f4192463e8b931a9fca79ecc7d304cb30d6bfee7f0ff8729e7f"
    sha256 cellar: :any, x86_64_linux:      "b56ca1da622ad4513a59a321db7a45e312ecc02f5fe8338192f645f47fa90fb8"
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
