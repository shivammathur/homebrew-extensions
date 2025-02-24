# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/8ee4631e3b82a5382f0d1c76cd2abdaa2f8c26bd.tar.gz"
  sha256 "a935c9a0dc66e3dffb388e249c57bac3ee94e4ebb7c1e63a77a39d6481155024"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_sequoia: "c0f1f8a3a9690f3ee04b3c69dfecff45efe7a4f7591ec39e6d0bd290b475dfcc"
    sha256 arm64_sonoma:  "41bd16b77cf5d7f133eb7fbb24567bb4c293cda16943aa5545ef4f5db4882233"
    sha256 arm64_ventura: "bda23d3542ec40ba25d2d34c5e4ffcbb4aa40386370aa55531dcdcbc0828f7e7"
    sha256 ventura:       "cc912e823ce7e882378a87d3877e3168b2c224f90d1a3a1fbc227f211e75597e"
    sha256 x86_64_linux:  "75a14b90ab71ef13ca7b98708d2de64dfcc0db46afdbddae1fe942804b081299"
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
