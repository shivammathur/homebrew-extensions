# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0RC1.tar.gz"
  sha256 "7f09508095b04600655db8faac08b7a58121a64ab3ecad018d051dcf44f7cab0"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "27b21392dca9ffe1651559507e1f619468d84090e7ac656e0f4ab4d41a6da8c9"
    sha256 arm64_big_sur:  "f82fcc9730f79492b6abb08c49a968c7b1c7519fc50e280f96ddd52e8e621190"
    sha256 monterey:       "60c8c42e6a1dff8619cd3cc21d0de9a3025f082b2eb874fbb1552aac4c04a997"
    sha256 big_sur:        "98df92656f87a11cd6007c9e0b5b02d5e76c101f5b2cb6de2a7c771821db0456"
    sha256 catalina:       "9d598b2de1c8bef59738cd85c7d6bb8cedd92fb5be501ec05a65e0eff9170901"
    sha256 x86_64_linux:   "c1f6b9395a0a050a00b1c22b94e56be7be650088d99d571db3523ee2fd343428"
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
