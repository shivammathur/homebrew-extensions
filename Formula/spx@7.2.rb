# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "918e0ef844457b4e5d65e9ec53f4b2923fb564b194d88eb87a7400babe92993b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "de42a78041d430fbc4d406bcbd23f6c0c32d1c233472345326e6ffe704af4382"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "08d7ac3b4fbcb0a562316a961e212aeeeea69b5d16820ce75bdabc8290be883d"
    sha256 cellar: :any_skip_relocation, sonoma:        "788a5ec8dda691f8c22f1f7acd4385f3c1ba96999c09932b81478271bdc0380a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7389d8e06be6fcf147f84195f096bb8474f3e868da40edf0335d7eebf6370c22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6dd1a15b3d0ed9dd0890eac92992ecc87e023edec08410b9b7246b3bc6d7fe48"
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
