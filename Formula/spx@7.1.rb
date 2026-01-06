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
    rebuild 1
    sha256 arm64_tahoe:   "8f3165290c4b1fc86807fda7bced1d9003f0a580fb62036b36a4b6937089097a"
    sha256 arm64_sequoia: "8d3d2271c261a2de816e50ade3aa5b0082327dccdea0b0d00c5c5ccc0ffb3c7e"
    sha256 arm64_sonoma:  "0336986bd997974278a6927e914c55a3b3e336dc4aad5a74033fe96d505245f3"
    sha256 sonoma:        "a2d5497aa5f5c4307d0965765a8dfd65ae53c82921ed466e2e0d6c3eae7b9234"
    sha256 arm64_linux:   "cc26746e64f5d844d41ae06e4d76b14ecf9da06a21b8c5d6a7a45b249d97bd21"
    sha256 x86_64_linux:  "9f85096fbbe00b3992f72392a5af6add8edd3d27c83fe135ac28fae1b86a7f15"
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
