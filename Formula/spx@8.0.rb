# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT80 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.20.tar.gz"
  sha256 "8de7f8e6137667dbe7e92ba552ccb3b3b3745664efb9af88ece8bda0f58fc94f"
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
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
