# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/a27262d63ca93117e6cffe2e617731be13030165.tar.gz"
  sha256 "c36e3d6dcfb2ca847a5c3c7975657f55f8ff654deaac664016f220a7ee0b6948"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 arm64_sonoma:   "ab3c8a5b4a26c767cc4b2ac567c6ccca5a36f51d601cbdc8f38152aeda81562f"
    sha256 arm64_ventura:  "3411b95a1c6cd50fa0f2ad3bb04bca3308f297db2d83d65c41f4f38eb0db809e"
    sha256 arm64_monterey: "1ab795e4d5264384dfd9675541c50bb3d6b770684e55f4319c04876105267870"
    sha256 ventura:        "0492476cc6e3303dfc1b85b7b99c2da6267af93d8ebf342d60b2c8cb07110822"
    sha256 monterey:       "05a013aadbded6a48341b94bf52d2d561b472364b9dde6256291952deabbcfb3"
    sha256 x86_64_linux:   "2895b2cf9ce54a360e1171ccec7d843454de4925c783c40025978b4428c94717"
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
