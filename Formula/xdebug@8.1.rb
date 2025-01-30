# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.1.tar.gz"
  sha256 "9cf77233d9a27517b289c66e49883bdb4088ae39056cd0b67c3a1d8596b21080"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "fbd4066dc5b7b84c4ba30d3579a601ec6cfee7e043d12e782e6485cbc500e14b"
    sha256 arm64_sonoma:  "dc6b10c5ba4d51758ae48e8434c0d76badb8aee591c539d1a601bded74891c2c"
    sha256 arm64_ventura: "bd5558443ced583af0cb91d60ed1469da76b124a154a82456be1aeb6413979ab"
    sha256 ventura:       "8ff415db3a5460ec5c1cfb392a960fc9cc17d6a498e95b43c52c2d4dd9afd32f"
    sha256 x86_64_linux:  "6879b2e22dfc7fba7417a2c44acb6299708fdf304a1c3285160fe3f9e11fcd2e"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
