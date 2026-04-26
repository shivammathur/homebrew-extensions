# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SpxAT86 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "0eda0bbfd13c64e05926a8b8a1e8c13c6e909c81923f7da855b863d4ac41b30e"
    sha256 arm64_sequoia: "2aa72bcb0819414909ddc0759708966bcb401016f931106eaf3bee46fb88ccb8"
    sha256 arm64_sonoma:  "f8e59258d11d9b45ea7b07ed256f257e042fe9c0d20c8cd91bee9287d0a81d31"
    sha256 sonoma:        "ade25cfa2cb56fac84d6683b9c4b70ab1024c0416c8499f2197d0a154b008853"
    sha256 arm64_linux:   "3838627e8be78233f560238ec23ee48c7d7b52f695b95699ea1d32f01c702499"
    sha256 x86_64_linux:  "0b23bfc937ee6878e715d1e6e7355ffae33c8e209d15e7a2ece51308d8df8776"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-spx
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
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
