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
