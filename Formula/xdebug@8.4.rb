# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/41f0ec6509b37e967771cfd8b133dd6e2631e842.tar.gz"
  sha256 "0f48c6a099de2bd01f1bb9385af1debd99664d6dd82d56a3f4b668676021d7d0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "be1384cd2b8aa0eb7a948784b0fe59e351965a11479f2504c23c7d67f41e062a"
    sha256 arm64_ventura:  "f77122323d469ffe02d9bdb39b272cdae676a36b5c28d035ef3419a1ffd395d8"
    sha256 arm64_monterey: "412487948c3dda805e27f1781757b9ae034c4a8a500a2d6a46e47b7196aa21cb"
    sha256 ventura:        "2eb98350605bee9a85fed8634ae25414e0a5a9cfa6a40dfff39032001c4156f5"
    sha256 monterey:       "0b709ffc2db420dbe89fa2ccc29c76120ffc916d4ea562e96aabdc5fdbbf5916"
    sha256 x86_64_linux:   "1f6105ef209fe6fd6dd1657820102640ffe7174cde62290fcce26649e873426d"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
