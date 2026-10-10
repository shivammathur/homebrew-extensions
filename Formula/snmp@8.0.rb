# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1bb9988fd6c151c783653e3a2257c1a0897e6633.tar.gz"
  sha256 "1969f16cab5dbf112b0f1115279d061f29f63d8910cc56c497cff59c853f9f6c"
  version "8.0.30"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "af90dde15e77b0febf939d40ee8fbbaa08fd1272c1067dd36a555de255934e45"
    sha256 cellar: :any, arm64_tahoe:       "9cc1e7fcf5ebe83097e5141399901c790ca1002bc82956c81a79fd7c1d0c1828"
    sha256 cellar: :any, arm64_sequoia:     "4bd85ba8766a17794df72d6507b3016899b13a95654db90037eea9970429f7dd"
    sha256 cellar: :any, arm64_linux:       "cefcdf4816a759fe3018eb1cbaebd527e10c792ac38ee357317ce6cac18f7ab2"
    sha256 cellar: :any, x86_64_linux:      "ed96ce8cd6fb61d51ac6532ff586cda4d42ce3ada93a0afb101b0b4f76e0732b"
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
