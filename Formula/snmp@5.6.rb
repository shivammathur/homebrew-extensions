# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2f0da72721b16b74c602d3c80f527e07d1cdd49a.tar.gz"
  version "5.6.40"
  sha256 "595bb86a07ce587ae98a04cf1d3cb23f2280a90867a11cc312d67a4b1e87911a"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "57ec45d459233494d53500352d66844d7f504bd97b0b6791869b7602c92c4f57"
    sha256 cellar: :any, arm64_tahoe:       "d57de8b27bcb58a3f854f5aad917e54e86bfba5c6a373ffeebec00b2aa07a30b"
    sha256 cellar: :any, arm64_sequoia:     "7200099c009a354537b17d5a5154c0043f493c5c08376a33061eb6b0ab548523"
    sha256 cellar: :any, arm64_linux:       "521937adec0b84c532c64280a01b3d8b2da00e3cbae00542be1dab1234b55113"
    sha256 cellar: :any, x86_64_linux:      "445b10db66013f7ca6e1f723099dde8d5981536dff2f7077175a4ee434a25359"
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
