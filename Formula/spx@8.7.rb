# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT87 < AbstractPhpExtension
  init
  desc "SPX is a simple & straight-forward PHP profiler"
  homepage "https://github.com/NoiseByNorthwest/php-spx"
  url "https://github.com/NoiseByNorthwest/php-spx/archive/refs/tags/v0.4.22.tar.gz"
  sha256 "6f89addd100d3d71168c094612eb8e1c06fd8062da6ee4d9df5b31bdfc4de160"
  revision 1
  head "https://github.com/NoiseByNorthwest/php-spx.git", branch: "master"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "25265eb12cccf539eb7dcc4974945a7c0bdfc108f803508665e3a4f653debbaf"
    sha256 arm64_tahoe:       "c9e28230f72b1a5e800a9fdcdf2432cf259c46ad4d98c8013fd96e0d565a60bc"
    sha256 arm64_sequoia:     "4af2366bfe9521fa770dfa9a99df4743fbdcc73b139a7cd52dcb1b2517212641"
    sha256 arm64_linux:       "77748fc57f6b338b368e48bae883fbfabd27f167b078a81f5fb75d2c3e6448ed"
    sha256 x86_64_linux:      "4ef9b3007dc3f9d3d6f620d0e25760fbf55200b3b8852a97453d5af296aac26f"
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
