# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a1f82c4497e5b7a7c492caa262b2bfe29abd8fa0851247d9524dbc4ea6a56a8d"
    sha256 cellar: :any,                 arm64_big_sur:  "235c3e03b440fe2ce7ce7a14de40557a99da09c2f0b7372e419b093e3a2012ca"
    sha256 cellar: :any,                 monterey:       "3797cd47301c2cfa8c8c0c811a9a7e955aa09130fc3fe22125a9c7a978c43442"
    sha256 cellar: :any,                 big_sur:        "89bd1bebcf8e12ae65adc47b9cc8590110542fa61761a26319a68fb502554043"
    sha256 cellar: :any,                 catalina:       "994d2a38ada214dfb5beb07d6df1f88adb470e7862ef12fa825aaf6209b0cc0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd1a6d4ab20ee7909334a3ef23d7de553da083d8447285376f5f11c63c12e67f"
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
