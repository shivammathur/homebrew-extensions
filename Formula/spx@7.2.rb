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
    rebuild 1
    sha256 arm64_tahoe:   "a414a0d636ea0e0ec566c2698a0ddc0c4f3f974b2c2bb250592da2dc439e6492"
    sha256 arm64_sequoia: "48db64766becf314e448b4a1b221b1e6ca7105616755c0f828dc4bd10a68d233"
    sha256 arm64_sonoma:  "a35c831e834a5a1560c2a301ee2e4c41225b6c8c38b84223acb667fc6927fe2e"
    sha256 sonoma:        "5af4c60bb12eb8db4654038764847ecc592ddd142293417db2f625b429df5724"
    sha256 arm64_linux:   "11276896bf46bc6e9d64ddc4ac2421dab5f1c805ed2467a995631d1b0fd50261"
    sha256 x86_64_linux:  "e7127e6d2cc70497de042918edcaaee074feea86150ac12bb2dc3d2dbad6c355"
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
