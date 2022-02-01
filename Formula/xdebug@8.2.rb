# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz"
  sha256 "b8f54da6bdac2dfce2137c8ff4adf2c39c7f7001a806270e07a4d0c25f791f06"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  patch do
    url "https://github.com/xdebug/xdebug/commit/06c7f670e78fcd7867daf30d10eff785a50e033d.patch"
    sha256 "0ecd654aa184bf5974532d107d92dddd4337bac834a1c712d2dcf73c3545aeb5"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "1e6bc7c1f1c31c64dcbfa0923627a236798fd9e927a16b7387ed007385c059d5"
    sha256 big_sur:       "c9815ef98e03d842889ef7ee424ccaa648a0aebcafbec54037affaeef8ed4e2c"
    sha256 catalina:      "6de989b8978dbe366e91e28c3d2a049e46d47dffa209ddd88d1bee8b741afab9"
    sha256 x86_64_linux:  "26310a32268e9bac1599f7b5cd856064499593ba297fd52c82bd3a77f4bcbbb9"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    inreplace "config.m4", "80200", "80300"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
