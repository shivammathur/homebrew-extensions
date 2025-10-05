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
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a3c90d0b80fc6e04d1fd13618fa56406cf16fd818739341f890d8398096a9763"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "be180ecc012950bcb2552756176ef423ecc9dfeacdb6afb12f7f8f70ac397d72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "705afa96ca7efa2361335aa1139428c15f3c2cf65307d9b002c1cc055aa61d2a"
    sha256 cellar: :any_skip_relocation, sonoma:        "f97bdd0db46a3342cc8764a64b77b7e11ecef5ec59c9f3b5aa330657a656e3ea"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dcc6ae8bfca31718ac1472e7053a4954944e83ab71a31a5936c7cee1a584dc66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7232a1a6bcbf91734eef3da964db0b0c7824f4d105465ed0b77a93dd9fbe1af6"
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
