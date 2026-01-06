# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT74 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "e65eb3d0b9f44ca1282dc8ebaa6d4ee7b6918cc02852b1f9aefb27c586b8c080"
    sha256 arm64_sequoia: "2aa3497603a6af10125c38c228148a2147b07f6c426841994362925a328e3c24"
    sha256 arm64_sonoma:  "6593cbb583f3376e820d4c18105d10d594ea15ce3206656b5ba6148fe3b5f000"
    sha256 sonoma:        "69e53a4fedb4e13c5851a8e6764ed45c15e0c2f2e247db32241b955567f95e98"
    sha256 arm64_linux:   "23e258adab5d414d8d31ee588f57e4521d0bb4065069e3451ad929aca017ad39"
    sha256 x86_64_linux:  "e3c643431de75ba6a04b883899720d3ebac82efee2e9967712081555086a768e"
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
