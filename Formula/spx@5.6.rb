# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT56 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.20.tar.gz"
  sha256 "8de7f8e6137667dbe7e92ba552ccb3b3b3745664efb9af88ece8bda0f58fc94f"
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "51606cd9960e8fe099251e4ea7f7e94cff7fc30004acbdd8f11e53d357d96d9f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "05b0a09d8d8217039fc7ed612c98c866ba42111da4e90351f66f486c5d51ce8c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bb8a4100c30a6b48068586bd7baae85821f441503f4bf2d86795f4edb77b984d"
    sha256 cellar: :any_skip_relocation, sonoma:        "107bb4e0fc5335ae54397a2ad596ff1c83362e7ea8ba51597405449015d4be87"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "add7e459acaeaa9a296797f44cf7fd9cd43833c35b392884d53a626af1fe956d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e133c7d0a9b47ba7294201d0e198dc3066e9e54db19555d3938aca2b65167cbb"
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
