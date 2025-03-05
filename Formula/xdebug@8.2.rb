# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.1.tar.gz"
  sha256 "9cf77233d9a27517b289c66e49883bdb4088ae39056cd0b67c3a1d8596b21080"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "a734c412faf4cdaf398e5b08dbb8ec98a0c7487f4a4d489663b5e0fb02c0f351"
    sha256 arm64_sonoma:  "9dffaa5c79a41d0804e4681858387d6aa622c6fc16b9c4f706e0e4622dd82872"
    sha256 arm64_ventura: "7084fb0a8453fdedc73850644df14a9d1f2295ac2e6335328695380ef9f4fd64"
    sha256 ventura:       "52e76d90a110bf8febba81d50c4cf21d76ff54da323d2059c0d9987d06431edc"
    sha256 x86_64_linux:  "d81179a8ad8eb997a4278332a46fdd72f76e4e77a801887e6e26df0b30d106c5"
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
