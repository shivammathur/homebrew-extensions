# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "87b6308dcf18a37ea3807bf6cc82075cd670dadb2d0100dcc9752d718a7f2206"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9bebad7b31d3a1a454e9edb7c11d56290fb2cedf05191a63b080142593bcddd0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "98ab822a5da7ea404e7716cd91b19fb5caf5bd01b313ea25ce8a27aea7fdae2d"
    sha256 cellar: :any_skip_relocation, sonoma:        "8f9645a37ff6b3768d44d7b4a02b682f04871ed5aa62f44eaf6fd9ccd37abaf7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "630f8aea54ecec95789b7131a0daa691956bf92a7a99237177de9ff44aae774b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e4412872dcbae1675197261ef0d00acde44d35b7b9902a33f18d322b2d72e94"
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
