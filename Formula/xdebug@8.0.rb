# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.1.tar.gz"
  sha256 "76d0467154d7f2714a07f88c7c17658e24dd58fb919a9aa08ab4bc23dccce76d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "96e3cb9e64ceb4bb87d6a7c14b0a2a94a0535c3274d1d0b3604ef8cbfb489949"
    sha256 arm64_ventura:  "a1e32f6d08f47179c14f1f5713dc203e3fb6a7432796ddbd6d14c6fcb123c543"
    sha256 arm64_monterey: "c5a561c957c3fcc21da08c8401e045ad2c5f8906a75c400a34c81513e43e745b"
    sha256 ventura:        "f05f2fdc9b724a2a08fa553a57f7591205c5ac24889861a884a27c7bb4e6de27"
    sha256 monterey:       "4458b2db2cf6fe03042dd9af88255eeb8a647879f0b63476c566612c78494048"
    sha256 x86_64_linux:   "4f6b4864122fa2539e510be308d8602078129f45ac8c4ab632540985d5d85415"
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
