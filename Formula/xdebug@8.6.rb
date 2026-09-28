# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/55186063b4ebb86103ef2a59dc63e347f7bb231d.tar.gz"
  sha256 "749b4cf78da90b69233541988e041d02fd3b6c92f61e1ff9e6c46d80c7868bab"
  version "3.5.0"
  revision 2
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_golden_gate: "f0d48a61c5ac44692a8d791ecb824158679d7cabdad874bc95022d99e9ed92b6"
    sha256 arm64_tahoe:       "0b9479eaa8ae1eba11adf1e3d1aeccb0bc0c9c6554c7cbaf0514d724b7e2ec6a"
    sha256 arm64_sequoia:     "3ddf9f134118009bb75affd862d8793c9d9063fdbc5c2ff5515de42769eb7e4a"
    sha256 arm64_linux:       "c865bcb1eec718e37ce91a1035fec5848482d5a8f2b1c5225035b9e5d4d79363"
    sha256 x86_64_linux:      "fceb7560c95a2cc85d320f2321f0084b65972f84915e346423f40bfd67664dbf"
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
