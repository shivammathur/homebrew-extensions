# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3194d42b765ed6a825af683f32c7945d5201aa27.tar.gz"
  sha256 "9331d1a5a790b2f5e24dbef543d9772cec3d7d2e49e44cb2b91c22f0601d378d"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256                               arm64_tahoe:   "a8c655acf2a96caa49a90a36d0b4211e6623dd7f0ba5a23ce92208d90b5a2681"
    sha256                               arm64_sequoia: "0ab372aa41da78f5870ea675930336dbb70267e5afae6a85a127275c1c318dec"
    sha256                               arm64_sonoma:  "b2735b1e3bc84c1a7f36fb3d315c45e4d25623aff7378bfe28bda55ab7b94825"
    sha256 cellar: :any_skip_relocation, sonoma:        "f22ca74690194eed832dc7d9a4a16d64c7f6e13c918c096272d53fc25b419a5e"
    sha256                               arm64_linux:   "b3c1ef8ddffcf39df35c0b23daf0893033e5f88f53b40a80915486e554e2b4bc"
    sha256                               x86_64_linux:  "9daa8057bdd61d8053fa534f8be4790a9cf178dfd16854b129a76a4c1631ba1f"
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
