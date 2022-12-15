# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0.tar.gz"
  sha256 "a5979f2060b92375523662f451bfebd76b718116921c60bcdf8e87be0c58dd72"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "d6312b8b4e92892e2533cc0b8a802ecff34b2134ba8c073e198461ee3dd3b5d4"
    sha256 arm64_big_sur:  "d34a302b9fd3951200897d1a5696362761a8d9bad15ecdf3ef03e28b1738a49c"
    sha256 monterey:       "97cec33a0cceee5cbcc16f10de663ccad24415dd98f1c7b610742166ae83ad91"
    sha256 big_sur:        "52911f9ecae06b1e7f91d9a780d6e7d7300a6cbfd2da3ba8bbd5d399c972b7c5"
    sha256 catalina:       "82634aa084880d51763f43ec484ad57077f2fd2ec4ed1a3b0a6223d332d9dfc3"
    sha256 x86_64_linux:   "b8a5045a81841aad5b96e9a476174bda2f387d94b4eb0021ff4dcec19bbffe29"
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
