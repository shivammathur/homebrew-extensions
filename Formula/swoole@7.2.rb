# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.8.tar.gz"
  sha256 "36a942e894d83057404ef849e87ca344f31dda0d4277f99cef46023e2ba70c52"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "bdf8fff4930819c97960100716be217b50e70d0afdb23906567159617c906fb6"
    sha256 cellar: :any,                 big_sur:       "bb0b69138b6caaddd6ba72cb80fd2bb8d4735a54462467e979ae0db845a41203"
    sha256 cellar: :any,                 catalina:      "4ff2114ebb3ff0804b6b263a94c433e31eec29eb7c5bf850956643756a0bd511"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a9f5d78b51431440d76f110065c8940e281bf792503ca9d833bf82da68d976ac"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
