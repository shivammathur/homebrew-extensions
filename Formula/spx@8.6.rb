# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT86 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.22.tar.gz"
  sha256 "6f89addd100d3d71168c094612eb8e1c06fd8062da6ee4d9df5b31bdfc4de160"
  revision 2
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "145b381a62d197f822f4fbe4fc9ffbf8b727f823c0a0917752743aef3b1887f0"
    sha256 arm64_tahoe:       "c01dbfd5635414a5d659eea9ab3d6f851cdf26b3ed332eb7440f44754ce902da"
    sha256 arm64_sequoia:     "0fd9bca5582588a1de211bef0f0a28dc75dca1b12e7042f1d73d0e2530268c2a"
    sha256 arm64_linux:       "e8b42e47edcc4362b82f427cc8443bd4e5df806bf9d3b64d45f6396acb9afe05"
    sha256 x86_64_linux:      "2ea43fcacb7dde7be69c139525d04dc3d3cb086b720606ba1d6cee89f7e81ceb"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
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
