# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.16.tar.xz"
  sha256 "7108b7347981ad6e610aaf3b3fb0f6444019ab6f59a872c1b55a29bc753eba93"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e3139d16b67a4b4b35136a755cccddd3b458f07fa492c0caec81a70efb9f52bf"
    sha256 cellar: :any,                 arm64_big_sur:  "aa11589e0aca2f19a4e28544f70fe69aa0202ffc488a8d10255f156401ca06ec"
    sha256 cellar: :any,                 monterey:       "887a791ca75a33e725944ae61555ef29e99024d999d40569df6b5335e0868b29"
    sha256 cellar: :any,                 big_sur:        "1eac118723840d106e971f83a670205bc14790eb30cf3d25a268b6db25c0034d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b74fe2c93a48c08dbd16b43532b2108c7894e8b04ab9d66aae39a7881a8dd8bc"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
