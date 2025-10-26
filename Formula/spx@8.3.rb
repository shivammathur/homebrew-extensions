# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4a2071812eb5826b10291665d3bc11a4a53e42656aad24d76ada5887d7949894"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bdfdb9b13271cd2cbcf2cd9c5d12d05a172f9f44cd0bd8042f3f697ff2533a00"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1688f22a22d06d18c5a4eb2261f1ee3c3ac04002353eb5f0b37b3bcde2e7d653"
    sha256 cellar: :any_skip_relocation, sonoma:        "a321505d8dd724771a55092f2b4aa8d8e1bb2819af6a0835bcf68b295ef14da5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7affae01067840e94ffd42d44f8e6aff43d1405b1e29097fd40068146e996a12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d84409b306bf57a8173867b2ad676749815614871c02a64d2918ddde2cad8516"
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
