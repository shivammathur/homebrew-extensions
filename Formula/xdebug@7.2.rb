# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0.tar.gz"
  sha256 "a5979f2060b92375523662f451bfebd76b718116921c60bcdf8e87be0c58dd72"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "5d7066a60dcd0021109cc2ff23ab298c1c84848b9ddb74cffc6d28509f28e077"
    sha256 arm64_big_sur:  "20bda8ad690866b3bef1101607dbf4427e1f27fbd9ec13e02bb11273b7ff6dab"
    sha256 monterey:       "8b5971cb3363d1ec32ed93b68b5eed3ec8f7e0f0382eed1be5e60e731abd0fc1"
    sha256 big_sur:        "26f5d3b930fb64355ddbe237dc78435c3573735f889227dc3bdf1f3db3a94a62"
    sha256 catalina:       "af52dfca0ec4c3a78c4336a3b39693cc7e70b5272b8f859585b529473ca00a8f"
    sha256 x86_64_linux:   "ce295be1de45446f85f0117abadad4fa272f84778d3b43accef70d398ea9f5d8"
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
