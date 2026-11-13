# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT87 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.22.tar.gz"
  sha256 "6f89addd100d3d71168c094612eb8e1c06fd8062da6ee4d9df5b31bdfc4de160"
  revision 2
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "497c74cbd9e503d2072aca91a9695c3dd02fc2933f7d7a14ebfd5951fad149a5"
    sha256 arm64_tahoe:       "2ae13a8e928ff4926fc5ddba96156dbb772bac72c6d36a283d285aacd8551bcb"
    sha256 arm64_sequoia:     "05aeeaf86d693b6dfd9e3abb5cc638e224dacd055217888b4baffea76937b66b"
    sha256 arm64_linux:       "ecde4216315bc04d8fe383a9ae011c5e019e630b24ab9ea49a33e7b17e43ca6d"
    sha256 x86_64_linux:      "aad60a7ff77ef926de41452ff84cab6ca2e60d9b813829188bd2fa2f72227e83"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
      --with-spx-assets-dir=#{pkgshare}
    ]
    inreplace "src/php_spx.h", /ZEND_MODULE_API_NO.*/, "0"
    inreplace "config.m4", "-std=gnu90", "-std=gnu11"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    system "make", "install-spx-ui-assets"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
