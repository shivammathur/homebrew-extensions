# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.2.tar.gz"
  sha256 "9d2001cb8c4d5a2f6302e1bb303595a01c0337dd4e0776b05e8abcb526020743"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia:  "2487bcb311fc26a191ed608bb75f1b2e76f5553796f3688d56e64a38ceaa882a"
    sha256 arm64_sonoma:   "734051fc17eb7951c0ea3cf03f1f56594a1eb5aa0c279c2229a511f4a467d501"
    sha256 arm64_ventura:  "997793849dd66a18bd889470a43d06db3cfa3a4483055a76657368082e884cfc"
    sha256 arm64_monterey: "38387702e5cb17530695370c4a08ccdfbbc4c4388d2ec266c17d4182b8af3f44"
    sha256 ventura:        "d2c35195b385b818bb7cbc92f2913d6071ef6abae7732f5de425a59840baea1d"
    sha256 monterey:       "052010043a5c455a7b3298640af83ee48cc4d536b7675c21663cbbb38e3a3419"
    sha256 x86_64_linux:   "636de562143f407c4eaae8693ec9dc39330b240df6a98633b70642fba23fe32e"
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
