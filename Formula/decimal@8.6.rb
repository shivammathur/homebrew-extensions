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
  revision 1
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "899543a592e85fd025976e3b24cffd43a62487b75c5382962ef03ecf45f212f9"
    sha256 cellar: :any,                 arm64_sequoia: "36ab6b90280b217444e1c3993fed97115fbdeedcdb2341925719344247d04a8c"
    sha256 cellar: :any,                 arm64_sonoma:  "273d1b340a52166760fbafa6126acac8406eaf024f1b3627335053530f826e35"
    sha256 cellar: :any,                 sonoma:        "0434cc83c9d8cba2b1c2b8c97fa312251c7c6ba64120cfaf0039e7c71f691bb8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8fae15bb6465fa4d88ddf3bdde80a35074359857491f67fb219af7086fcf4a64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7596d41ed865d18e398f2d1ae9b40b074be5556f2d79f4cf23a753f64b18539"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
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
