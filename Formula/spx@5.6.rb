# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT56 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "84723f2c0d336c0e0331793db3a797f6ef8e98cba3a0a9d514eede9288c09695"
    sha256 arm64_sequoia: "50baebdfaea0ab65fa0c17281a83958bc386f24090ec4bb181be56d046ec2871"
    sha256 arm64_sonoma:  "e7bd288e82d60789c24d0d114253ad61c548277c05d75d22c5fb52565cd336e3"
    sha256 sonoma:        "93d2e775a42dfd82a508836d36f89799e13a3f065f8391d82bfa98943dab1c84"
    sha256 arm64_linux:   "7382361d501c3446946e66d80ca0334b940bd714b89dbef4ae68fda2087bd561"
    sha256 x86_64_linux:  "014972b2cc89a2fe9b266bfffb4706e287571909081d1a286a39c3ab9ebf13bc"
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
