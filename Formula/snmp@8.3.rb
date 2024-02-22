# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.3.tar.xz"
  sha256 "b0a996276fe21fe9ca8f993314c8bc02750f464c7b0343f056fb0894a8dfa9d1"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "8ed87a952475d5b6209e94567256072059ac39a64b33e525111b5a0cba7a65cf"
    sha256 cellar: :any,                 arm64_ventura:  "a1bb3ad846e5f7b02a4692035294dad1d653f4fb31211883155aa7f4c3d3fccd"
    sha256 cellar: :any,                 arm64_monterey: "7f2afb5bbf7fdd246c621e132314fcd15e01086eabd12a2c4b5d4028c0e986da"
    sha256 cellar: :any,                 ventura:        "e618ddb722838a7bbd6b88826a5c597a7336987e91dd680f5d6d9a8e479fad8b"
    sha256 cellar: :any,                 monterey:       "75f235938f1a85056fa7d45a195e3db1caeb13903f0d97831e04ddd7ce904fcc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4f75085517020147ef8dd382ba058dd709a24bdf0d01d80df8307e4ab06c35df"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
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
