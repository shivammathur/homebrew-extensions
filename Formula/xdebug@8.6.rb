# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/525c09315902bd99b46aa44bff854a260b2bc78b.tar.gz"
  sha256 "b74a938c30e3ae0d90f683f1dd29dc3b4aadb1fb1c218434ca2c8a3559d31eee"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256                               arm64_tahoe:   "e931ae6097c6b60e3cda83a992b961f4538e687d69712b2cfd3a0e928ef297c3"
    sha256                               arm64_sequoia: "b29153c2ab4b97f6b1cb1f9c8cf51dd032ace03cbb8421eac52696f50730fd6a"
    sha256                               arm64_sonoma:  "5fcd692eb27fa87bf0269108f714f1c08b1549f319473e7ea1e3cf5265bc6a1c"
    sha256 cellar: :any_skip_relocation, sonoma:        "23a6c1f1aa1055051f2b11309df600f5604a6b2705f3699e6549c72fe3869f27"
    sha256                               arm64_linux:   "e64395972e227e7eb37f211cb7e02e7eb782824c89b1db2d334bdc7f188f8969"
    sha256                               x86_64_linux:  "a3e47055d3d589202dbe844079f6f687712bffc902a9155d891c2e74d9ff305a"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
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
