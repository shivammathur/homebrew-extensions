# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.3.tar.gz"
  sha256 "988f518407096c9f2bdeefe609a9ae87edac5f578ac57af60f8a56836d1e83a8"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "3356181dfdc2a4938c5ff8fe3245cb48840190660f40c3a8868460c2c612b066"
    sha256 arm64_sonoma:  "2a3bf58f88e7d2d893490312a4ab0685e61305558e4f1edcb42b6790682637af"
    sha256 arm64_ventura: "8bbdbe2fa68a63ff8da3f7dc2845ffdf7618412d08bbe6a7a1d16d29bef3a197"
    sha256 ventura:       "810b0f2cd2011c99dabe770226ce2caf761325689788c38a11386cd8f9be36f3"
    sha256 x86_64_linux:  "94733a03aba5cdc1e923b45b7be9644f5d0d04c0630293d4ffd48f49965b603d"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
