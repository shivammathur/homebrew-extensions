# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/9eda8c70d25926fb53a4abcc93a5f836488af4f9.tar.gz"
  sha256 "93ad850d6d019d3ce507f20e09ae6bfc8972b0af3fc1b1219b4950da8829e329"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 arm64_sequoia: "87df9d98f767f68c6758004ba6b7ffd6ddafe2cae78b910f16aa4675b6804c7a"
    sha256 arm64_sonoma:  "a04eb3b3d1eccc5e15d8f76bbd2e9e41da6fa5ace19de00bf10c87f78920c6ac"
    sha256 arm64_ventura: "97b9ff923b7dc733f2827b825d6d2f3859e10805d19b0d7b790ca9812b2c70d0"
    sha256 ventura:       "64a79e75e6900eb8f2dde03f54d7f555af26526117ef88f831cf87b11280cf92"
    sha256 x86_64_linux:  "dcede72d171906b7a59440c9943d20abaf31938c060ad107d59967ca4a30f16d"
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
