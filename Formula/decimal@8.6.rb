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
    sha256 cellar: :any,                 arm64_tahoe:   "43768b126ee81e47ee5411064edfc29e19a11deda28636ac5a052fae089ec610"
    sha256 cellar: :any,                 arm64_sequoia: "1901ae0481c6805045d86bd4a5df3f580dc9edcf85c62e47130eca9377f3d74a"
    sha256 cellar: :any,                 arm64_sonoma:  "c8751b8d99aa87b7d717bea91cee36e72668ded2854805e1be1e5ced5696e17f"
    sha256 cellar: :any,                 sonoma:        "77d495be580a80ee2c21cbeb28b2aee0ee12cf8a037d7866a92256d002db5e8e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3a07b4bed41e0315f140a34855bd1e36925a5fd1bf1d5d94586788ef172a7647"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b767d7c425a471ea07990e5398b98e4cf4c2ad26ec6641b345f684dd74f8a689"
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
