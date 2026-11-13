# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT87 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-2.0.1.tgz"
  sha256 "026e30f71016d25f267f9b38ab80a94bed4779e05e9ff5f48d9b08bf1c18d204"
  revision 2
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "7d81f2f85c6281e36de2f44353847e96a87049a83abc7da5a5d3bb93c6d3a725"
    sha256 cellar: :any, arm64_tahoe:       "3fe50b31a7d32675f2f0f794f508abbd092c769747f7daa2abba299435940a00"
    sha256 cellar: :any, arm64_sequoia:     "5be69585e57097618759149a3ed8f0418e11f1ffde5255aa7033c02cc6ebd7fc"
    sha256 cellar: :any, arm64_linux:       "7353f805980cc395dc169f366593ace31f44e837cbe626afad2724c69c7e44a4"
    sha256 cellar: :any, x86_64_linux:      "9019e61ff42483b15b4a4741e1b1cffacd3631a284659cc602a5fd8d373a7b58"
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
