# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ea710e4a768b498a1d8d25dd19a95a61e9858b412247c35d0159253d5268b7ba"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "200f0d9d285f11aa7c7a979b320875254dc611bf72b240799f2377f80ac2687f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f31113e33fabdb288147b9b30deb84b62dd5dd876e9f91292317a776026ac75d"
    sha256 cellar: :any_skip_relocation, sonoma:        "3065f6ffe06bdd1b7d5e3da826b83dee16f0f184370d86759f536fbb82442356"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "78ab289380b194daaaddd7ed69753a2ccd8afcc6df9dda25033a138bcbed6641"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "92bd1dcc03d463074ef4c62071a2c304973c50bd88d9274b0c72580f14747d28"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
