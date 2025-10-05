# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT70 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.20.tar.gz"
  sha256 "8de7f8e6137667dbe7e92ba552ccb3b3b3745664efb9af88ece8bda0f58fc94f"
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6d24045f5cce1bb827f158bdf09d0565153b0d062be81765eb3af4d7419513de"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f015d8f2cbe47c16e8967c6a3c04ef0bb71cc56614a2cc4aa5ba17e88476bfaf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a599d868da682d8e5b053f90591dc32ed8b6925e7dc02fe7bd3406d19013f1a0"
    sha256 cellar: :any_skip_relocation, sonoma:        "0527bbe7c60ede21f36d8e7afb1bc562db3a95b9ee0e3480bfd3e1c38ef16551"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "70aa3124e2aa2c3a61e6583fef8e06fd3d405b6e9a24c6d41fc778bbcc3c46c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64d136f1952a573706bc6d3f4e66a2e984c829f818161a99e0435479293cba6c"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
