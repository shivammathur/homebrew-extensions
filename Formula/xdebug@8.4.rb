# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/80d4be0522766eb5394f15528fd616ea7b96e62f.tar.gz"
  sha256 "08de489c0a9bd4004b36ec400ae0e9a3369bdcd00f913cd5e2f32c02c4f63345"
  version "3.2.2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_monterey: "52815000075c4e6d5860b8d449c4f017e5c95dbb27e12956ae446b9529f0593a"
    sha256 arm64_big_sur:  "240572ecaa7b135493bb6a86b7da97b62bc8c464abf62a0a88e48df957469991"
    sha256 ventura:        "a64ba60ef7a6015e0f1709f80ce09a317a301d15131883fcd40a34d1f04f8203"
    sha256 monterey:       "2c86e072042b91eb6c5f47ad9938a506c6dc8c44f122d915ec416e1c1c83f4af"
    sha256 big_sur:        "d8d549992f3dad652307b0ea3b3a3bf447188bfb42128aa65a55ec32e4fc7708"
    sha256 x86_64_linux:   "5bcffdd2c5cbf50c27cdf7a93f8f42b4e3882f27ed83c026d44ac91fa09151ea"
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
