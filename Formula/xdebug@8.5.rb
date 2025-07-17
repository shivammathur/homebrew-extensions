# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/4d7890252a1d544b94609440962030d6483b34ef.tar.gz"
  sha256 "e905bc9110b95d390b11e4d09dca39464e10d7c950e9d63133b65553ce608912"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 arm64_sequoia: "d1fda850efdf5d30459f2549f48055c31d025cfd28a17780de5cb39fe22cd46d"
    sha256 arm64_sonoma:  "03f2e1770c0d8b50bce50a62b8f69195aaa094fde084a08ace32bbec53a8f44c"
    sha256 arm64_ventura: "1270b962f157203b31a94c9d6868a8b36c98190beb7397e6114b2ccc15754a39"
    sha256 ventura:       "4c2515e27764d3d4daa955b18feb73efcde628523545eb8e90d5701c75cfdacc"
    sha256 arm64_linux:   "0d90f49e957d7eef5435380e47e4464a8b67cdd8c672295037ffdc8d821666d2"
    sha256 x86_64_linux:  "40f7d3f38ef15fcf5a87cbe374dfa40ec0a440ae707ec2c6cfedd085aee89b05"
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
