# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/141ce2f6b542abde318f373cc927edf8fdb68cb5.tar.gz"
  sha256 "7b91ab7bc5c2568ed38f29514efcbc57415c0a8f6389c609dacb0e5589b9df1c"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 arm64_sequoia: "174b36e671fca6dbd95302cd0c0cb84f521f3cc8e1af16c786ffd84032b7f2b3"
    sha256 arm64_sonoma:  "5aef1f61beb86049d328e673eb7e897a986242e91c10fc93e5d64d884899363f"
    sha256 arm64_ventura: "21ea934e853f4260c8ed516a041561aee90e50f49fe2e6b908a92a164a744b84"
    sha256 ventura:       "525c1551afc352130a5780efa76d600efa57d8434c6877ff287193b5149827d6"
    sha256 x86_64_linux:  "e2368c14ad80783cd9c53a26ec91392ce271d5eabcacac43ce686821006fcb3f"
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
