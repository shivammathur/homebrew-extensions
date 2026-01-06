# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT83 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "e7f819659b034fa9950fc54cb7caf744d753b5b001017744c6100ba8d0567a37"
    sha256 arm64_sequoia: "741a21b4bff17c5b1fab87f4ab8441bfe04266f9f1f6d84c601b6023d928f7d7"
    sha256 arm64_sonoma:  "02b3f05d5235331f9174e31154bf8089fad1098a020744772e16df94e7b820b0"
    sha256 sonoma:        "fbe0089b4cac4dee3459b31a917aaf848ac86710dac7955b634941a1dc521577"
    sha256 arm64_linux:   "7f79d48abdbf37329344ad87a581faab5b4cbb26e08bdcd133354c14baaa0fae"
    sha256 x86_64_linux:  "c9b44e7920f9725059fdded0391be8ba085800374ef976f54de47ad0cf429dda"
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
