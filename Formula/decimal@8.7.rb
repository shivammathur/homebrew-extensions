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
  revision 1
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c0d79ce498cd102808d4d05becbeb43cc5873758e1c7fb1849934eab1587af22"
    sha256 cellar: :any, arm64_tahoe:       "6459e70832d1ad79e1d267285e320825ac9d541e5ed5f7070feba5448b48f846"
    sha256 cellar: :any, arm64_sequoia:     "8230cb493b13fb61728ebd32db1518defc287183798469344ff3a125e8ed745c"
    sha256 cellar: :any, arm64_linux:       "070c2472fa7af93ac730e4b2b66cefb491386f0c082e6eb5504fb0d200693d16"
    sha256 cellar: :any, x86_64_linux:      "ef539a425df70b650a052cdc21909ffbb779e32848505336009ab8522d7f1b56"
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
