# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.5.tar.gz"
  sha256 "30a1dcfd2e1e40af5f6166028a1e476a311c899cbeeb84cb22ec6185b946ed70"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "4171aa3df64aba73c4243caf8f98f2d29c516d61cc169221f3136437dae9b1a7"
    sha256 arm64_sonoma:  "8e137b7e0881225578c1401872fe4aa183a8d242d01c87e534560ec33ad8545a"
    sha256 arm64_ventura: "619210495b3787c4f65a77390f14eb52a6c8ee783464ac9de7b6ed53b765a9db"
    sha256 ventura:       "fae1e4d5fd38c308731f64a631d5ca5b1fd952343402116489295ea6d5c41ee2"
    sha256 arm64_linux:   "86254eaa4ea13c362a8865dfa7ecacfe9d4cd119ec5259d274471df76c7881e5"
    sha256 x86_64_linux:  "7bbbe90686540f0a9a873c5b96915e6f33aa6285401912c4584a79520361e8e3"
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
