# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT86 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "d6a8983365166b5f01922dc9842f928b7ff36bbafcfa69a0b5f7befaafaafda8"
    sha256 arm64_sequoia: "55458ffd96026d79e2fa0d5d00c97a7b97cfc7b31337b60897ebe27936f7bc5d"
    sha256 arm64_sonoma:  "91d7ef27e7c055c05f09bd03f0dea4ca7cd19760c9fc2e0662da4a9caa9f9fd9"
    sha256 sonoma:        "14ee02e09089956db0290555cc9876fe0950f3f96c381e23414baa31d8219a28"
    sha256 arm64_linux:   "9b84401079b5ed7099d86688b951dbdf66004de23cb0f52e2c000212dc91c7c2"
    sha256 x86_64_linux:  "7da70d497954a8cbda40c48cffa36926a6caa252b9d9cf4c2b6a438a33fac9d4"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
      --with-spx-assets-dir=#{pkgshare}
    ]
    inreplace "src/php_spx.h", /ZEND_MODULE_API_NO.*/, "0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    system "make", "install-spx-ui-assets"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
