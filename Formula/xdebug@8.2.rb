# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.1.tar.gz"
  sha256 "76d0467154d7f2714a07f88c7c17658e24dd58fb919a9aa08ab4bc23dccce76d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "5a251506f5ba5ced4c4e2ca3d6c6112aef9ef43a02b4ab5de5a074bb2e3ae2cd"
    sha256 arm64_ventura:  "e1b316a41f1aaa9b23323318d900227b7226cef8cc435ba7a63c36e468c70825"
    sha256 arm64_monterey: "c83983f384c0fe728b62983a1447c21afd606d7e7b945493184ca05bd911eb9c"
    sha256 ventura:        "419ecb5ba8a2a5353537f44d6a4004796bca3df472659985f5d9d2c9adc1f0fe"
    sha256 monterey:       "5be670ccabdfe18428e4c4294449aeeea0b57543fae327b2b06f94586256f367"
    sha256 x86_64_linux:   "04d2d685a71b55cda0b6d67e5d8dad157a82cd38db338eb1bae7b15b5888e470"
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
