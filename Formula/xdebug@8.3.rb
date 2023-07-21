# typed: false
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
    sha256 arm64_monterey: "7d9ab0840c92b9b019162299814060334230d55d4aeb21b05288d028ca6e1f9a"
    sha256 arm64_big_sur:  "e618add8aeee3a7a8ebc2d59c7837141d446b7a310b734f22b605f8c8c78bc7b"
    sha256 ventura:        "48629494ef027f306e41820dc511d096a91513cbfba08c9d1b464124eac32280"
    sha256 monterey:       "afc3570d6b71e75579565f0aa1f89ba5e614f2540a673c873a9e065e5b1b2877"
    sha256 big_sur:        "c6444a6eff3d1c3ba044d45f9e9c2acd9b66a68c0b895901beedf1795688a142"
    sha256 x86_64_linux:   "ecad8d4b897ed9db85f82d12395f1b9d966ba806fd66ff672d552b2a41a8b643"
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
