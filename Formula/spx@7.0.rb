# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT70 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "4112ee4e6937241132fff61b207a553fc0d5713374b99f00548a6b074702acbd"
    sha256 arm64_sequoia: "7248b0cbd35f8d317a8448fa9d32c5e4eef96563dd2bc13e2916c31dcd97940f"
    sha256 arm64_sonoma:  "b81b23a8f52b9864b6bb189cecc6d1f2c41df5aa75810888b47984b103f2d607"
    sha256 sonoma:        "840014c997620a98a64b5fd4706658ac0c3863542b47f40c39da9ad5b83af3fe"
    sha256 arm64_linux:   "09731bb167887208db7dcadcabad32ce280845c11355e19bfa3769d61f39f062"
    sha256 x86_64_linux:  "2fc1caefec00ead60135193adede820ed0d0c3840ddd34c50ce99cef12047563"
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
