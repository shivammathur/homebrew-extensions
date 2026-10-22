# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/066522cf9c489c59d41bfca7cbfb08eb36fe4cd4.tar.gz"
  version "7.4.33"
  sha256 "da5bc8dd8f95b172b9be7a355f5e0b783a409c01100d305ff234af207bd39552"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "9c43e8b1b9fcc73b0f24bc2e549642a88dc0e9d028e1928f62491181a8d994a2"
    sha256 cellar: :any, arm64_tahoe:       "2198ba4e1bd0a60ad747c1f64fb5ae3f7e67db646ba970cbe5af81a7030347a0"
    sha256 cellar: :any, arm64_sequoia:     "9697ae4e1d172089a3907380f5119dc38542e3a48263f091c92181affec5cc72"
    sha256 cellar: :any, arm64_linux:       "4f562e2e4c705711880d6aa411635098b272d629adf5471b1dbe10a4b37fdc36"
    sha256 cellar: :any, x86_64_linux:      "2e7f1728fd7c7bb0c2e1dada731f3f4774fb3a70b075a3ec09ef2324bdb9fac3"
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
