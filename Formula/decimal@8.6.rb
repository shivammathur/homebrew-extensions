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
  revision 2
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "9c5c82076584139a35a7823d7c5bf84ac4a58cf219d30502df2858a2fc6ec5ae"
    sha256 cellar: :any, arm64_tahoe:       "a3cce46fe3fc9939e47e105be68d638c3e8814be8e6dcfa29f75eba4f773c932"
    sha256 cellar: :any, arm64_sequoia:     "cc3983b01b8f96bb92175057283dcb69fc952ee3914af462f1112f72c9e98d18"
    sha256 cellar: :any, arm64_linux:       "b4010c332c2157aa5c40c5669a7a43ece30554477c9d3bd0d71d19cba0d21b20"
    sha256 cellar: :any, x86_64_linux:      "da2889ce36743997b8399d7cf911d891a63adaaca88f740e18451bc01387b756"
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
