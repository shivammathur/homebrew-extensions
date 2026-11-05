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
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_golden_gate: "b0829790eee57e2ee87590ac543ed2cef96d187f4d00b460504cae65afce13a0"
    sha256 arm64_tahoe:       "063ecfde60fc51f42ac1700589b2fd37c43ce836cf95b13b4e3326b3d36a2180"
    sha256 arm64_sequoia:     "78f32006a969ce5ace778e4e9600d860dc237c4ce088cface76cb72a64dbf16c"
    sha256 arm64_linux:       "6fb29ae1d2463b4dbacb06a5aae61907eb6f90866133333760a765e7a4cd6b1b"
    sha256 x86_64_linux:      "593c97120a8cf804763a98170e40a0920bd80f154c9a652b19951315ef8a03c6"
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
