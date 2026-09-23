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
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "07fe28e4ee7a973e25641960d127f5306f73314d3b8447405444a4a1de9cdb48"
    sha256 cellar: :any, arm64_tahoe:       "fb4b9750378256ec72e2dbc0f61516fc6a0c525b28cb3b577f72817b6e6d9f54"
    sha256 cellar: :any, arm64_sequoia:     "c0b59b60501c088db071bee4164ca5af18edd44d77a6603da135dc8f6e314f3e"
    sha256 cellar: :any, arm64_linux:       "bf7b4e71154a94d8e22a8d2362caffabfbd236961023156440a0bb053dd1ca4b"
    sha256 cellar: :any, x86_64_linux:      "d25cf5fd103da0aece6bcae889e39f32ccc2993940faf0fdc6f9505a6c892f75"
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
