# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT81 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "6970818677c9c568d2a10e9faf3074fd4ccbbeef35adc582aebea9fd4d5e5b01"
    sha256 arm64_sequoia: "9552832c524082c25e0245c5b7e68f26c32f2856b25d396b3d9a45e5e47aab3b"
    sha256 arm64_sonoma:  "3de765b7f33fdc08cef897c18704ba3aa2ab007ec3ef6f95df276bae78a7e204"
    sha256 sonoma:        "1b6b2c540a62915389328815a765c40a35570103216075bf501084e9ef48eac0"
    sha256 arm64_linux:   "bb12ac2656219599882e8520b52e388b17425eb9661084433efcd1d55d326ef7"
    sha256 x86_64_linux:  "5bf0208e4d3392664730a12f991c557227f1e917dd33f0b22d5c8bc178bdf0f3"
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
