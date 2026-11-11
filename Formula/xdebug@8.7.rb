# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT87 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/85f513aca01e2edb9b854b6c1bb0f550e62f887b.tar.gz"
  sha256 "9d42780a3a02247cda88bc7cedb0ae8d88a81d44aed96cb21f199916c526aea1"
  version "3.5.0"
  revision 2
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "58b6029fa26486fc7ed804a45b1ad2d0dcf5c41b3f9116f1014ddb24b8e84913"
    sha256 arm64_tahoe:       "7cef602fe98d88cb745459c521407d9b9facbabdc6b40abb5b123af5f41f0646"
    sha256 arm64_sequoia:     "634f91b89823a3c7610636c449a81608ba3000630655d3e5747907977f20c0df"
    sha256 arm64_linux:       "1408a52f585a16be2794278a914e5992d7f2b0e57385bada60271c1a5572e387"
    sha256 x86_64_linux:      "f463aa2aea65bfae92268e0e103290dea16261a3427e9f6bd3d333a10162de06"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "config.m4" do |s|
      s.gsub! "8.7.0", "8.8.0"
      s.gsub! "80700", "80800"
    end
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
