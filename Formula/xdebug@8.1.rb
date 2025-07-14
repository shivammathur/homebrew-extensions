# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.5.tar.gz"
  sha256 "30a1dcfd2e1e40af5f6166028a1e476a311c899cbeeb84cb22ec6185b946ed70"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "1b5fc442911220ec67c070757aaca0c2de75e57e8a656ed4a74c1e9332088031"
    sha256 arm64_sonoma:  "9d8f8a38a120de816da9d49603370529756a4d74405f677acb8db58c540d2fda"
    sha256 arm64_ventura: "4f57b2d98e72ecb92a7fea7841b96afbac1479bedc2b76dad2ff7d797aeb37b3"
    sha256 ventura:       "55bd292340274ff9d22d9a093cfd105aef753cd16b85d38e3b8dd36a5f3b2061"
    sha256 arm64_linux:   "b52c7235be56f240d8eb964e215b97e502a1375d6151fcd8495e5e2466403719"
    sha256 x86_64_linux:  "0df9adb1299e4c58e4524bfdfb4d911273c94aec019fe2818f4c63902bf9017c"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
