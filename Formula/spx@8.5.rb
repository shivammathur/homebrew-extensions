# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "68e7f386daa490f709c3e86988344a96b3926b43a8eb02cb014d594d695d4094"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6dd31abf24177ea53ae71a9dee888e13651e1ec7a7926af50866d44a90ab7870"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d38bd0c15a0774be1b9268522ec35d26ff61d3bb6222b9faddb76ba63ab655ca"
    sha256 cellar: :any_skip_relocation, sonoma:        "698af934cab9ad79f2d6c5893bbdfbcc0b46b0f4e2e9aabedafac9e18eb87414"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b7ee5608eda62b2908819cf75b776f520c69e8029eb5b09816839f4c0635440e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "07b86e86b2a33046162509d01b32fc032972aa2421c59b5ded72fe3b03d1901f"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    inreplace "src/php_spx.h", /ZEND_MODULE_API_NO.*/, "0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
