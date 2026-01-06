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
    rebuild 1
    sha256 arm64_tahoe:   "89f6043e825b37f2a8e4472c70a2d2282ab34c7950f97311b7a7b11aa5f5e8e6"
    sha256 arm64_sequoia: "6aec898a48de315d70584166ac1898495860983a094beabbbc596b5c6f4f993e"
    sha256 arm64_sonoma:  "ef9293318bd7300603cf7a0ee9b95ed1776b68f061d80235f9d62fad2e1ca42c"
    sha256 sonoma:        "f0fe30be324fbf865f40fc9926884a308d9595b06470a02d5f22f0360e5b23da"
    sha256 arm64_linux:   "58d05da043df6bfeaa3ef0bcb99e62ada47d31558dfdffb24a0f3d672fd72dd8"
    sha256 x86_64_linux:  "bf7565a9435720a6b4aeff0845b61b54610a46d562a8e469f7b9b247de0c18ba"
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
