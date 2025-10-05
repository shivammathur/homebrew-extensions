# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a5a58f79eae529b989b37b40cfa29db4ce12457f1033a9e0f214dd6648d8c452"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6e0999a71491934407eba525706699dae6e3c9946126521cee9d86538b54ec61"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c02ebab4f9167fea857a7e5494267388cf91919e7a62358b85beb9e97c65aebd"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ea48934c8286c58f6c6c83c7608ccbbf65a8f50c324c3a71804408db34e895c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a17a1c7bf4074df86ddd602455d4295b967f5e8a0454267f093953add13ab7a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "73592abef9296ae7d59a241e45a08553323954ff7cbf04d7228ab4f13e5a2c0d"
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
