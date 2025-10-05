# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dd955ee7a02912b160ea058b4793e3502be92d2295355885ad46f1b2285abe9a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7b941468868d6f179799c849d09d897c075f8fd3e8dd8ca462545d027885691d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "42db8b863dbbc0e8598bd4db1162642c8919266e006007ad034a38be3b97ad3e"
    sha256 cellar: :any_skip_relocation, sonoma:        "6e58608806593040a45e33249e06543c91cd4f43c3d8e431b35a5bfaef970067"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3e54a338ef7828ac46a410be9bb54e85b92fdc7b59d54a0c0dcc6a9b23af5e57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3a492d8d003b71ee273967d9d1c5b1e53b49780cfb0897d79509abbe4872b37"
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
