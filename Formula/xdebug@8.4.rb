# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/6647902aad7a2434d4ef5a5dbc667272322413a6.tar.gz"
  sha256 "610afd6a70e4179c4fd492b269fba9d7f92ca5a69ae313ec313f3d05a58c3755"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_sonoma:   "ca5beb53c06ed494721f387c9a1998559b790610c7b5f04bbd5bdb3ba5991dc2"
    sha256 arm64_ventura:  "da8a11434f793ff522f887671a3a32f4e4700dd35f83c85963515a6dd37ef121"
    sha256 arm64_monterey: "82537fa043d60a1e5e1ce4d5d27f893e8a2e5d5c6320982edf9b708f2e9e6a45"
    sha256 ventura:        "c2bb7ef20474894e275525d3ea583e048e9099795def428d6f82c0870867e758"
    sha256 monterey:       "6495db06e1a00b2ff2d1aafaae26b25c2a5869d845f006a183354a787cb01c2d"
    sha256 x86_64_linux:   "68b29eb4283b669381e6c9964a279281c4bec31f8ae5ca30a6b7709a63f464b7"
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
