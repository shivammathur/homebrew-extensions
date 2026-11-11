# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT86 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.22.tar.gz"
  sha256 "6f89addd100d3d71168c094612eb8e1c06fd8062da6ee4d9df5b31bdfc4de160"
  revision 3
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "95edc7764f2513aef708f096bb4519a7c9a1e2ca6d6e323bdf8b281ff38ebae2"
    sha256 arm64_tahoe:       "6d649cabd5c89409e5c34af836cd576ebb71bcb0883f90b97dee9837b0e5d180"
    sha256 arm64_sequoia:     "b60a36eee905a46fde79becb0e09c912fd3aa4ebaeb7654bde4c41f1abeb2e66"
    sha256 arm64_linux:       "237880c260d976078540ef1648d166e4b995ee466fc5f54deed75e00b622da85"
    sha256 x86_64_linux:      "4e2cd1f1c8bced98eaadef0f6908d35b3a343a68407420d416bc0443b08ee600"
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
