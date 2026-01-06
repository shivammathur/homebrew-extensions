# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT84 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "1ea8ec258b99dd1a58ddca32b665797d66787cfe4215e157930519480df24406"
    sha256 arm64_sequoia: "5c50b88c06421823d0b4035221dac52e1aaa51675059cd90b9d0316b546ca374"
    sha256 arm64_sonoma:  "9332f1cbe9847298cb9416fc1dc81b5691afa758d73c64b1bfb44a9d39ff4692"
    sha256 sonoma:        "22b7f89554bee93ed84917f88f58f8ce11c8c423ecf5272680ae1be44e5403a3"
    sha256 arm64_linux:   "939e9b3489346e510b7e8a1659989edf7f010baf248df4fc38502369a52b8f9a"
    sha256 x86_64_linux:  "463f9b3d46438f77f23c0f9ebf956fd45be8dd3f75b0ad745133ac06d39e6fc8"
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
