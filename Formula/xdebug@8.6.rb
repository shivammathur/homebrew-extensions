# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/9f1bf000563a2be6b5318e86793e4a1024fa470e.tar.gz"
  sha256 "3b5fa0e68d229bf3fd04aa9132c9e7b8260910942ce5fd506c0bd5c3308af449"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256                               arm64_tahoe:   "abe86f2a5bd9491abffcbb78418871259c56ad3d7ce3812ddbe435094bd10069"
    sha256                               arm64_sequoia: "1e4ceff13e96ebfdfc891866230e75e59ede1bb372ce122a54b1cedaf0be3982"
    sha256                               arm64_sonoma:  "49cce7a828fd0cff0948d69ee461675f1bef4177dff895119dcc98eb2c94c143"
    sha256 cellar: :any_skip_relocation, sonoma:        "5287a3b44fa42d1f7463eaa5cd41706548a415664686d8637cdc7ec5181eeab6"
    sha256                               arm64_linux:   "6e7e545ab8f246df3ef3c40d327be25804f8eb1ded68e840733e917c0438554e"
    sha256                               x86_64_linux:  "0d1668058d28c949aaa2184eafe8d60b102512c9983e581ce131a2d0f0feed08"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
