# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0.tar.gz"
  sha256 "a5979f2060b92375523662f451bfebd76b718116921c60bcdf8e87be0c58dd72"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "a0230e2f80119e38b281f117eb49ccaf5524fb30abcf36b077ae98163e2d5664"
    sha256 arm64_big_sur:  "bd664488d2f2eba1897712ba8a85b414fd9806342999b59a7452987379895f0a"
    sha256 monterey:       "30128ba6113406ce03ebf362bdddb7472b7c4995cfdc920eec1ef4962a922f86"
    sha256 big_sur:        "94b17ed69b9b458d681a67bf27f1064f4903bf2d04112879df8951923137021d"
    sha256 catalina:       "a75f9e44a684008785b2b4b94ca0a1f2188a56627cd6ecfbabeb3c1c25158640"
    sha256 x86_64_linux:   "91be38814515468d58a4bacc160a7522848329f6005c2f2e4c24c5c764258449"
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
