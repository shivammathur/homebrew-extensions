# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "781e2f1a2d79f37c0d6884647aeee7a78061a41b07f2c8b80142d593265e0077"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "45547c7754eda7929be9c0c41427e0164c13be22948bb10fd3606a80d813eff1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f76d1d9a4093cf23f330e492fd82225988e2754655d8c601da5410350032af3d"
    sha256 cellar: :any_skip_relocation, sonoma:        "6f6d40268e56383c239e5ab641c3480c20cf255ee9c585587b740a09e8e7fd0d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ae9d8924f429e3d24a094255b335576c86c49beab7b79a912d68b98fa44257ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "42642789ce7030488aa9f3ca999d893053b4658385fab0e4569cf037885e94b9"
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
