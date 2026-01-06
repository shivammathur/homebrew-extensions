# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT73 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "a79f0c6f18a91e111be57929b9809507a7085ebaf907bf21d3e62f94221fb37c"
    sha256 arm64_sequoia: "fe6a46e4821f9f328e8c0c3e5af68fc1e2a0ee0edf58511f310a12601775eb2c"
    sha256 arm64_sonoma:  "0efc052f52100867764584450f02e3beb5d6ed6ac1c2e6ca6a4986f48053addb"
    sha256 sonoma:        "963bde60ec62105ad82632af840863e06342b123c58025a905129db187a8c582"
    sha256 arm64_linux:   "b9b3754728507821c8bce8beb9630170b512de4d6dec54a8300b7ff7d1c2e046"
    sha256 x86_64_linux:  "9811a74303900664bc2f709c51211b07e829de0c9c339e27f728e67c366024db"
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
