# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.1.tar.gz"
  sha256 "76d0467154d7f2714a07f88c7c17658e24dd58fb919a9aa08ab4bc23dccce76d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "5f77a7db832a6da50e82a6077d89d169f1478805addad3f9aa5e9bc05f8b308e"
    sha256 arm64_ventura:  "f26ed1307ad05eba0105d2c1eee0ecc4c3159a2cf5dece8283e5e50552274654"
    sha256 arm64_monterey: "8ffa64998a4d7458ffc5a07dc340979e1d77b5b9d6fbcf873ba52e6bfc7dd57c"
    sha256 ventura:        "ead5762bfdb234444f5af619ada8c4168d0186ae1c8657bbed4d11ef5debf814"
    sha256 monterey:       "cfa80a1f130ab6fe1183ae5f9fe17575d31956cd0c37e9cdde94cda80adac00c"
    sha256 x86_64_linux:   "af15af08cb0f8ee9782e0e850b0d21b50b9def1676a16eaceb24f99a6f07ee03"
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
