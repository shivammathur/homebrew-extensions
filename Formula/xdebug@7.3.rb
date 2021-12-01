# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.2.tar.gz"
  sha256 "57cd63b25649171218c749f8fed808dea7d641bc4fbb4427356d00056ac24c68"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "6ddb4687500cec7bc0a185351f89471a65f5c31b741ce3ea378f01543222dd1a"
    sha256 big_sur:       "cd0f1874bf21ede461555260f8f303ec922670ce9a3c8bb6bdbe310e6635b0e4"
    sha256 catalina:      "233f7edb8287b7e4c8b317ef0792d283f4d693b05ad9f043ba7a6694cfc71cb9"
    sha256 x86_64_linux:  "3cd6b6db89fec5b66ed12b8ff6e6b5c5ef44b996d26c494c020a41a3166ffb7c"
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
