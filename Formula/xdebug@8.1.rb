# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.3.tar.gz"
  sha256 "988f518407096c9f2bdeefe609a9ae87edac5f578ac57af60f8a56836d1e83a8"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "c5cb079aefbd74316175cfc2bc00a1805accf2a0873948303e4dfa96c06cb144"
    sha256 arm64_sonoma:  "a58bf7cd1450db84c20933dab2e21c3e7ce114fc99a69880b88d63752f29101c"
    sha256 arm64_ventura: "2cf1b0a5359daf369e25eda8e9be2b9e6303937904fcd463d56a1c7e97fa484a"
    sha256 ventura:       "08c05f18cbfb36d53170569fbd3051a0dd5276dde9f943dff65a27df93765dbb"
    sha256 x86_64_linux:  "e8733bf7a948cb1f70bd22d646d03d17d66289d02e62ecb7032c33663006e038"
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
