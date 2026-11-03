# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT87 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/64007df3a0925808022fb87b6c6f06febf058ee2.tar.gz"
  sha256 "375de81fecb552cc2c66768ddc510ff43cc267e2276dce17b9a2e52efc73a1f7"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "0444a026572ce7994a504d4aba3df1725282ab1cc23f898008d1a33ba0676cc3"
    sha256 arm64_tahoe:       "b96496165ba6cb53d12c505318ac0de0b2287d20fdf760526864a7e0c2bfbea1"
    sha256 arm64_sequoia:     "8a8c4a49aa031e58381c02cf29bd32dd15c1ac578019f8480b434fe16aa63a84"
    sha256 arm64_linux:       "b30a14e12c9c94f4a33dcd9068205aa1451d545dc392d38d6297ffad8bb502f0"
    sha256 x86_64_linux:      "2a9d6c34f092717e0c238c3a2c51fea7af0ea8d14dd871dff87eb6eaa4622dc1"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "config.m4" do |s|
      s.gsub! "8.7.0", "8.8.0"
      s.gsub! "80700", "80800"
    end
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
