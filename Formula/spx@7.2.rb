# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "54d21b05e39a312b3f7bfcd58173ed18e687bb19dbe7c8e93c39e8d282829f97"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "45418a2c55ddb6fe32e01cfb61eecf2b26ad5d9f2c9d0832a06f47ac5bf2c1d5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c5ca6335f6516f12a261e14cc7b6539b3f1cece3deabf9303f723b1019ca5dee"
    sha256 cellar: :any_skip_relocation, sonoma:        "b3a9e6e780b2bb99b652e2f9833a8504217cc10619d507f777970d61d6a93fd1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8e6848fa423fc5c3216d5531d4a68adf26a09155ad73b326fb4c746f57cdced6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "99c5a1ae2c8734fa7bfb97a7967389b207082099333cbeade2e32ceb9ca9bb83"
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
