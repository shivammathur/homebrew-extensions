# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c7874a4d0db4212b13cf3b3735e4eb78d9cceb083aeb1dd9320c80a11e37fe39"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "641aa7a78c29591196f7c96b0e1cb0c2cff5548fc93fda12c281c17c8c348f49"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6b3b8f3c7b75b0fb7f775a823a1d0bfc9ef7e030210853f1d52fc27e51f27834"
    sha256 cellar: :any_skip_relocation, sonoma:        "9bf6a7aa4e2ba48735e06ab78744ebcd34a2f4ea4ec9807ec0201f7dbe22f494"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "881f7414b550ec94a1577978e70b948f829d830b981bb00584806378b31fe0aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7484879b3a41d2915c414df7019c00a757cb388e1f48d8061925957c03c0f29f"
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
