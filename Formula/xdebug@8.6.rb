# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/09f1713aa69c95d3cbe4644c30fcd2fd60ae8d90.tar.gz"
  sha256 "bb3c3642f1b7903034b5f5d14437887b56e9a7c50cd01d46e4c6f78695ef0c1f"
  version "3.4.5"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256                               arm64_tahoe:   "9e063ee5c00278efaf7a3a3c99eff8fa1b414c9c86592d263c23ec57c1897fe9"
    sha256                               arm64_sequoia: "8da84e94c39a58749bd9d9fef193a9f975871657a986800078041fa34841e309"
    sha256                               arm64_sonoma:  "2639b6557e714d77211a659ec566ae376d7b52ae4a0d3be2701ec7e2291268ba"
    sha256 cellar: :any_skip_relocation, sonoma:        "e1d10a42252e7df007918e83921ee3db7c534217ff83dca96d908bead5177ea3"
    sha256                               arm64_linux:   "24a32ef920ac637096fcc19e3b682f3186a6131952dbfa440afa360e32a6c209"
    sha256                               x86_64_linux:  "fa5070abd0c322f6abd1cfa620c59db55a8137e273838a1fd9921e10372d8378"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80600", "80700"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
