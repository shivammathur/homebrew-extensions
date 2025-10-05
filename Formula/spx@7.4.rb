# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bbea9ff6a4704a2c578a672e92317c1bf33e4c4664b9d14b43c5a68291bbf1d6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "78e960057577eed955a22d6fcb982b3b312546eff7c98f6edb06e94ca1490256"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cdf8199fd0eb543802ce9e4cf1abe62b4d861b4b18d1371a831e0f6ce5976272"
    sha256 cellar: :any_skip_relocation, sonoma:        "edc09d0745e9ea93053e5f358d33c6233fc35cfac2113b0c225025c9b1e58bf3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d251a7711429ab6bd3a3e1ffa3d6db7e93b97c2beea4ac0a1aeacfae571247cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0403efebb4038602358bbb09779b4ef2eb0b343fde8afd743360758c5f938305"
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
