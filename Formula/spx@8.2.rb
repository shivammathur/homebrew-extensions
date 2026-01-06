# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT82 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.22.tar.gz"
  sha256 "6f89addd100d3d71168c094612eb8e1c06fd8062da6ee4d9df5b31bdfc4de160"
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_tahoe:   "507ba0868d1027bf20650ee967380526711d98f0924603d967fcb2bf28db68ff"
    sha256 arm64_sequoia: "4cd645f3544980e98ad904c988c8c49ae1e9abbd0f5f94112a466a4dc116c3b5"
    sha256 arm64_sonoma:  "6a2cd58b16d5c4f94077e7321f3c9ee11ffcd5971d30f56f73e9397d83bbe6fb"
    sha256 sonoma:        "7b67faf952a7dfc063ad97d4b8898384bc1089842dfdc76075022c76a9835f0a"
    sha256 arm64_linux:   "b9aa776c5b657e819dc287a0be929be18386c118fe5b619bd51cc9cc43dca650"
    sha256 x86_64_linux:  "5bfee7e025b5308cd3d110ccd260402ad696db90d182aaa26781e3857ba11a81"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
      --with-spx-assets-dir=#{pkgshare}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    system "make", "install-spx-ui-assets"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
