# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.1.tar.gz"
  sha256 "9cf77233d9a27517b289c66e49883bdb4088ae39056cd0b67c3a1d8596b21080"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "4e5c3189f1834b6f7b3dd036e568eede8a03166c1e0f9498a8faafce09b2450f"
    sha256 arm64_sonoma:  "9d4a327e8bb5fd8b933c0ebf524d02a47e131e1743ab8bc1d37ff54e9a099dab"
    sha256 arm64_ventura: "32c9c0a8328e260160b84585351911082f6d1338940a3bf3ecb068780bd3e2f6"
    sha256 ventura:       "eb5b12773d14d9e9724a2105ec62b6e85afeb15f70fed5fd3026a321fe2da0f6"
    sha256 x86_64_linux:  "8ecac6c275a320f5b3044d71704e26b0a2ef7f15f1561e87ef6c3a8e4b4e4720"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
