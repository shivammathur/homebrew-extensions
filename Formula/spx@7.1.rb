# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "03f3a840549085ccb6989848aa67c3dc8e2c91e58480cfb73e340bd467238266"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "35961b6eb455302abd8a7a3b26ccf04c076873007816b09641be020f549e79fc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "91addcf4a9a7138cbd3bd0d0b6c9be2f399a0a9ad37a5e142cda8f08a7dc874a"
    sha256 cellar: :any_skip_relocation, sonoma:        "fae234ab19538ec91cd3e904f456aa4aa629d566bbd4d39402cd085aeb85dab8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5e42ac8b58a785537de4c1a162bc04d3f9bde1e760b9b6a7dc1be439c6b4a33f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f268e611c356ba747b61e1104b231620cf8533c9f2af9fe8f4cd00350d05beb1"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
      --with-spx-assets-dir=#{pkgshare}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    system "make", "install-spx-ui-assets"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
