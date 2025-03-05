# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.1.tar.gz"
  sha256 "9cf77233d9a27517b289c66e49883bdb4088ae39056cd0b67c3a1d8596b21080"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "240c0a78d36a7c065ff5f30b7620351767d0dade5c8cfc8ebd3576ef4b9f9ee8"
    sha256 arm64_sonoma:  "44fd6cc795bcd1fa9a71c8e9a0c60a275e1cce7d64e4fb0d5780f8fc2aa19201"
    sha256 arm64_ventura: "cbaaffe8efcc67032f57ad936346d0e60f19c93d2165c7c5bbe73ff69927d947"
    sha256 ventura:       "3b448242517571e8f18264aea237fcab71462a242f3967a5004702aef17b1cc8"
    sha256 x86_64_linux:  "48935d4318dcde0f8525d19222a13b8bb366159f66642cc28f529bd47799ea93"
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
