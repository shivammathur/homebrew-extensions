# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/5e99179a40053f85aee20d38d768575455204dcb.tar.gz"
  sha256 "e91ada97daaf58166e275ac23ca1b8211284daf091f7e4cb05352ed2a7033c2d"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 arm64_tahoe:   "0a45dfdfde2a00b84ec639e5bb007215e367600a165b4bcbc8bf3e73fb992a04"
    sha256 arm64_sequoia: "984a2f956c3c69dd836adf23fb0c080bf7aff9efc948274a6d8ba155662ff50e"
    sha256 arm64_sonoma:  "e12bea03f23c99f0ce97a2d99f7827d0b251192271e2a172a0c45b4493379fbb"
    sha256 arm64_linux:   "1c40f6727018c2c1a7935b1bff306b0f7c978412fcec15785c3e422f289e2c78"
    sha256 x86_64_linux:  "f6a8a65ece6a018005ee2f6a24fe0d44fa7cb7c1ca285c685cd03687bc17e619"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
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
