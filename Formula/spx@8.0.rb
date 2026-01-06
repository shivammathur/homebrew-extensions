# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7c3653ae9de2dbcaf273d0c5e8ef12089b5aaebed4ff0390e355339329208d9a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "55cde1d9c0476d71c00129024b85a40221df0d6a913ef2730114b2ec824c9059"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "68045e7040215ac66f4c739f059b4222b63852039adcbe138893a4b7c2b486f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "fcab375745acc8f11b7c4dfdbc89539d8fab830190d5d1493fd9603279a31bb7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a319a8c2a04757c1095179a90bcb01f384c4a29749c52adee30f2b7a07cd1c85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c00a1d15ad34c78942b617f990171228fe914b00f109d062aaff2c856df32df6"
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
