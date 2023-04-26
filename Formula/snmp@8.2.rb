# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.5.tar.xz"
  sha256 "800738c359b7f1e67e40c22713d2d90276bc85ba1c21b43d99edd43c254c5f76"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7055c5195945d1b7d917ab5ebb6b3f35e5703f2123983eedbc78ad0756f95d79"
    sha256 cellar: :any,                 arm64_big_sur:  "aabc055a19f3be834ed9c0a874cfa23d58ecea3bdc495024bb12e15b485d718b"
    sha256 cellar: :any,                 ventura:        "bd59f9efdf6228f9e8916d56a094bc48f2c85a41409bb0daab7a3ac3145c382f"
    sha256 cellar: :any,                 monterey:       "a6c9de911ac5fb877259a74faa88e2c221321ed609aacb997106566c2d5bbec6"
    sha256 cellar: :any,                 big_sur:        "1ec5881bb7a435543a14532b79456b23d37f771b2a591b1549d1c636f7a1c252"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0f8a88782e5e3e42b6e1a4a1b8fe0834843ca9615e6f8aea4e84a190d25c884d"
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
