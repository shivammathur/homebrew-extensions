# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.4.tar.gz"
  sha256 "e906c231812ffd528f3dadf10070f469d82e392458a733a3e50dba7021e43034"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "05a9d63a05c26f0c6288d86161960aa5e12337ad97a030ab1481cc813b8cf344"
    sha256 arm64_sonoma:  "7c5465defce2b38066b448d81be557135771c38157ec40d440fd23c8f5ed5efd"
    sha256 arm64_ventura: "01d69b9805a437d297ea55bf1ddb905a9741984a96fa26eb04011c33d23d2797"
    sha256 ventura:       "aef780d5d8831f3af882a7c7a0130999a8eb7380cfe4e7425bd03e04c991350c"
    sha256 arm64_linux:   "e82b369243498d10829c3fff323bd20e46c1a8dba3ffeb60210c45d6b7099d6d"
    sha256 x86_64_linux:  "9e6fe9faff08a9898e08f185a23a81a75a911970726bf408efd8cb33bb017359"
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
