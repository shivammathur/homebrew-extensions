# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.3.tar.gz"
  sha256 "988f518407096c9f2bdeefe609a9ae87edac5f578ac57af60f8a56836d1e83a8"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "fd329733af65d1abc24e30b635360b5a51c2d18749b417e8f7acbe0034a96281"
    sha256 arm64_sonoma:  "62551fafe8a1cf78fd540c8d8e34bab90464d6b83ac124d91b58bcdd23f5096e"
    sha256 arm64_ventura: "03f0e8937e6597675b4f5222357342515a0561656742b93bcadd45e92e3df1bc"
    sha256 ventura:       "ff5ec7f87551c4e9080400b4d23f947c3ce7a546029bdbb24f94fc6d05a7f3d9"
    sha256 x86_64_linux:  "3292a70028c44780a0655f77f1256eab008f52951ded19a911e58c474da8768d"
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
