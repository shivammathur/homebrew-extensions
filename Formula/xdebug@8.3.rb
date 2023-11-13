# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_ventura:  "3ded4006a626dec9d835449da1ced50a85bf960d9507c14da98de4a3ff6f6971"
    sha256 arm64_monterey: "4996817fd945b2330310d9c130bc9ecfea00c9f9ace2c34c052b597dec9920b0"
    sha256 arm64_big_sur:  "ba2bea563c1f039692efba5abd0c3b3b883ae3455ba75adb83be5f93809d1c15"
    sha256 ventura:        "56844df65d3106471f4587d480a59a2cffebf4180427050a1c6117aa957a5b05"
    sha256 monterey:       "5a35b7cdd579f31f6b73dc6b76fc7c117bf3d998345cd071540b754c6899a3d6"
    sha256 big_sur:        "6bdca380a833f663ee48fa290f6135909cba13dd71037c2f468a1c7a8ea1a00d"
    sha256 x86_64_linux:   "f1ec1e75133d632836a3d46a3f5d66bcfbb5d1d927d6a2ebb69b1121465b15cd"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80300", "80400"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
