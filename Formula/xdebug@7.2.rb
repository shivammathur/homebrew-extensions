# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz?revision=1"
  sha256 "6620bf33db616ba52cc6b5976265d8962d8d23321ad5fd63b862c8d47eb5152f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "b4952d551effcce03bce2f58fca7f937918bc63295b4f8965d51924f4405683c"
    sha256 big_sur:       "04588049208a409a487bd30cba365339317dc38aa525d4f1c65889312458a03e"
    sha256 catalina:      "30db8b283530337fd8e6c9082666b0c9de565880a95644a6d06cb294df43f81a"
    sha256 x86_64_linux:  "597e915dc101612119be4c2c92fa144be54e674c72efb629313699953f583155"
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
