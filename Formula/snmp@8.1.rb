# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.34.tar.xz"
  sha256 "ffa9e0982e82eeaea848f57687b425ed173aa278fe563001310ae2638db5c251"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "f3e9b4572de8803035b002a2a782ae54b4c242835a31a36b6c3a43809ed60366"
    sha256 cellar: :any, arm64_tahoe:       "ce1e29b550dda9af37081175524d0b4a439a8845d78c0583d7ac6f98e69f9456"
    sha256 cellar: :any, arm64_sequoia:     "a5c0a9ea0e5ea02f120ad81986d0d9095b12c3c945a4a503e433016d38e257f2"
    sha256 cellar: :any, arm64_linux:       "d63983e6231f376449da92fa6e25fde9124826c2c0735c22c7ca4229cebcc028"
    sha256 cellar: :any, x86_64_linux:      "e6aa1a35c1aafe757510fa6d9e26435046d38be5947b6c55141033cd7cbe9c34"
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
