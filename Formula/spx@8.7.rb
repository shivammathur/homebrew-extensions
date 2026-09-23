# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT87 < AbstractPhpExtension
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
    sha256 arm64_golden_gate: "feb5bf02cf4cac74b3e1c051cfae2625f6f84fc6930e9f74bc04700fb34bedbb"
    sha256 arm64_tahoe:       "0b7c2aeabdcb508e9b494e9cdb41258854b2440f588ade5c579b20bfa3535ee9"
    sha256 arm64_sequoia:     "c6e4356c1ce9a323ae9f77a9693667f0fb9900015176977e0428f4190cfcc188"
    sha256 arm64_linux:       "252bf144a0b2943d222dd716e6fecbc1afd4c82e05d22104e95ae154b8c6c915"
    sha256 x86_64_linux:      "5f653bea44211d211cfcf3b576458054a1bcab5828695d7b1ede7fdef7d99c20"
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
