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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2c0a21948280d1181553277bb740f56730651d996b68dab8796f954c3bd8e9ed"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2c77092c0c28fb5a63a2122f7e6e11c1361a03c9866764823c60d1b6dfded34c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "715afe1780177b9eb90d670b61ead64e807b3ea49243a846825a02aa4a6e4294"
    sha256 cellar: :any_skip_relocation, sonoma:        "1d3a367e46d3dac7a737eeb4e7c431d13d6edaa7a630a6db8e6d0d19f9f3ff2b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "554b8b837adb91e480944618dcc425f7c464a250cce7c74ddb209b4a982dfbd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "191e044f50027f08cebcbd46ee4fea2b57f7de221c1617ee3a09152707595365"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    inreplace "src/php_spx.h", /ZEND_MODULE_API_NO.*/, "0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
