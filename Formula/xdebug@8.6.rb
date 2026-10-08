# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/64007df3a0925808022fb87b6c6f06febf058ee2.tar.gz"
  sha256 "375de81fecb552cc2c66768ddc510ff43cc267e2276dce17b9a2e52efc73a1f7"
  version "3.5.0"
  revision 2
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_golden_gate: "70ed90214eb445c1fe4a709abc57dd7b0cc364a5d61c850e5d2e9129a98fa794"
    sha256 arm64_tahoe:       "443d660669e6405440083a88898ce7d64f55d2007aad3d16f33349d20d4735b7"
    sha256 arm64_sequoia:     "05ad136919a10a0c6935c81295d005417531973222691c8bef0730a796a314fd"
    sha256 arm64_linux:       "16f04382d56f4a0653246b137e57ca9d92dbba477ca22f8c71b4fc8503b2928e"
    sha256 x86_64_linux:      "1e850ebbc325a7f7415e7be63689df670098b1b5fa17c2ec30840d67c07b1b57"
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
