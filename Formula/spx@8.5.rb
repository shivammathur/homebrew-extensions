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
    rebuild 1
    sha256 arm64_tahoe:   "a2da6e72e67c9dbcaf7125ceebf3e35f07ff5f14b7da4b85f8ce5899095d463f"
    sha256 arm64_sequoia: "2e40b7ea10222caecc43b08f0ee529fab706532778c4426feb3799fe8f295e6f"
    sha256 arm64_sonoma:  "ba43209fd9a49e10b825d35bde348eeba7e2226f569e707e8755f810e5876168"
    sha256 sonoma:        "1a48eff66b86496de95bb03d1884838314af61e677727abfa45a831a6d4f3ebf"
    sha256 arm64_linux:   "7ccae0dd7194687267a6b404073728b73c1117ab9948ad57c80d8ced0f49be93"
    sha256 x86_64_linux:  "2d0c22444e9c41f1eac218cdf284804fd69652abffae529af8f670aaa39c349f"
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
