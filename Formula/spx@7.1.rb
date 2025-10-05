# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "28adc36f8c11f5443a0ae66cb45dae64f5e53ce024a398b4a15fdb86226013eb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "71446720fa33e5e0b89a8d998800dd7cc10641eb30a38b1bd48a39ff43e75278"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "81b96010daaad523ab4ffd13162f1e31ffbf3cfc85499aa4d8702c549fcc37fd"
    sha256 cellar: :any_skip_relocation, sonoma:        "e54b04580e79a567dd52a5e70155cf404a8edd22bb34867c47c3d37ed5d39262"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a55187ff1dffd6245cf9eaff64c040654ee2ff0856491dedecb6aa6021e67f0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "84ebb7a6064dab6c5c205a6de68d83f45a7672b143e130905ca0fd9275c5bc34"
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
