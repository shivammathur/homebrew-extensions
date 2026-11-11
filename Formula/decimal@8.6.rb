# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT86 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-2.0.1.tgz"
  sha256 "026e30f71016d25f267f9b38ab80a94bed4779e05e9ff5f48d9b08bf1c18d204"
  revision 3
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "9ff0a01d7014781681bbf089e940247dc55672286b280b80213e828307aa20ba"
    sha256 cellar: :any, arm64_tahoe:       "9df180e6e8e9b0e1c9e7dad4b11bd7458ab1f269f60377233285ee10f2aa9b08"
    sha256 cellar: :any, arm64_sequoia:     "9e1edf40035390c852a2bb862e94875ac104d87566d76c8fe029823db81b9e01"
    sha256 cellar: :any, arm64_linux:       "e67c13b6956f6e87f301fcc904111a31ee37d2374d0ba0a09cfdfce99577f44c"
    sha256 cellar: :any, x86_64_linux:      "7a377146b3fc7fd25d7c806a44fe1157c722da179b1d3fdd62798ad7d3b6ca70"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Utils::Path.formula_opt_prefix("mpdecimal")}
    ]
    Dir.chdir "decimal-#{version}"
    inreplace "php_decimal.c" do |s|
      s.gsub! 'INI_INT("opcache.optimization_level")', 'zend_ini_long_literal("opcache.optimization_level")'
    end
    inreplace "src/params.h", "ZEND_PARSE_PARAMS_THROW", "0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
