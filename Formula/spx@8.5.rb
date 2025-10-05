# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "398c4eb9e5611dba7d251d3083a37fc7268d3721a8e35cefb613747f81693337"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "932ab6266779ba92cd593a62a4b7545366ba894ff0b3765123c65ca8d5c67b6c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "655ff46a735f2bce9b989fd1619e6ada9463efdeeb9258fad5e1e7c86c8524fe"
    sha256 cellar: :any_skip_relocation, sonoma:        "19e82d00b8249a383b9a741c7012f07168f04c62bd113fc76d65826cd8a238e0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "208d8d7afddbfd7e029e87f66e85bf155e387840b743f8ff84707192457f10d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3fcf3a894c3234b3b5b7ad72d5622653c745a35ec5f65a3ccd43f3aafa41257e"
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
