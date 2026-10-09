# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.35.tar.xz"
  sha256 "ff4630fbbbd94359134b7d3c223db59329905bdc4f5a9ef93d257b48e358619a"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d17dc837d296422d7e50d1f0f5e996a65830af15b4b200d32fab741f0a6b89a5"
    sha256 cellar: :any, arm64_tahoe:       "47f8678120501bc3374e2c30b4a1a7d16f8bf3c8aef66e8efb26a88e59a543b4"
    sha256 cellar: :any, arm64_sequoia:     "382bd525f3e1198dbc69ab29f9073cba05d294dbd45536f0df8d5b4b192fe9a6"
    sha256 cellar: :any, arm64_linux:       "0bd47096e21ce343b57a7638fd7b3a1035407e84c22573d39637754ecb65ae26"
    sha256 cellar: :any, x86_64_linux:      "67432d821034ffc5b953ef58608894b57996ad4fb0bddbceaf7e46f449dad6bd"
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
