# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.4.tar.gz"
  sha256 "be80d390b6fd425eef597563a4fe71a1fd153d2b9218f749023fac57e774983d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "6cc7213c751db2d10fbc0693cd05dff84d5cf3923701bc3d28bc8037ab4e0f48"
    sha256 big_sur:       "34b8827f3ebd5dea715656e0e6730ae088c588d84d717cf250480833515776eb"
    sha256 catalina:      "4e7b97165844fd553d40af670c25ada11a18450fc83113c4c42c401dc3e4d735"
    sha256 x86_64_linux:  "04641251bfa4487b1ea0ae930676147329be1ae4e8c437efd1ac3346b1cb70dc"
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
