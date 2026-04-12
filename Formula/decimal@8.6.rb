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
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "53e2816760ecbcaf4309e1c5e995f07ef41e2db30652b766a0b91efe70927664"
    sha256 cellar: :any,                 arm64_sequoia: "aa8a59e51029945a9ac896c49477ec5753d40628f1350414c87e64e46213f430"
    sha256 cellar: :any,                 arm64_sonoma:  "95df87625d09538f1213ac458f97fd58065e25aac0b9b13b733747348e7599f3"
    sha256 cellar: :any,                 sonoma:        "28644d97df3c22585b5f22a4f585a2050db5305c255491a2da2ae9b3df3f8745"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "16e0ef23f10d5dbe0a2a3cb301135e3709e51b4116a4d5c8385c0b66cf84a91e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60f27ee1eb19a08b719d8d937fefeb3a43c601b935d7d3e9499c44f68fc1dadb"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
