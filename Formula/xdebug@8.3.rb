# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.1.tar.gz"
  sha256 "76d0467154d7f2714a07f88c7c17658e24dd58fb919a9aa08ab4bc23dccce76d"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "11cdf61592a17e760f681158e186d9bfeb84e27b7db762607785800cb6f118c5"
    sha256 arm64_ventura:  "9d0bf9df62236886f81fe43954f7e2fa2258372c1a97a7aacb0c9899900291fe"
    sha256 arm64_monterey: "ea310e1972724fc9a1d42a4599f64cb59b010b7db2cb5bc49b7eb0ca90c4a26a"
    sha256 ventura:        "fb98036a44abb2ebd0346197485455f5bebbd50007a58531d18287e4751da9ef"
    sha256 monterey:       "a414ea2ad68e64cd8b03adf9c4f50a08e6ac87ca8e243a3c87c82000d857eb6b"
    sha256 x86_64_linux:   "db87895a356164dce42401adaf44a4a8b1a455e0977a2cfd90cbbe57af6145b3"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
