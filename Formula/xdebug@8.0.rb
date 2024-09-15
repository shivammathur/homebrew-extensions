# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.2.tar.gz"
  sha256 "9d2001cb8c4d5a2f6302e1bb303595a01c0337dd4e0776b05e8abcb526020743"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia:  "a23361e9c3a2489a6a58b76d2a6c1ced556f41b66ae674590c0489d016f73bde"
    sha256 arm64_sonoma:   "135bcbf599e13493b1437a27c8eb9f37ffb85c70c5689559ac7768701a3e0ebb"
    sha256 arm64_ventura:  "7e9da61d039acc412c25dd22675a0477c9ec588270617ade9ca9b9653ac7ebe0"
    sha256 arm64_monterey: "87a0e0a091009b1b5dd719152b03c75ba72f0293b05f862ef772f6a09ad2ba37"
    sha256 ventura:        "5282baca344e4f48a244ad8794fd90c9759795953046abc9aa2cdd5c42027dfe"
    sha256 monterey:       "0ddf88289a5c3ffd10b6296fb70cb0a5bfaad20fcda6fe792223612e4a50979d"
    sha256 x86_64_linux:   "9e688843b12b3f98815203549f1c06ea9ffd432bbc9ed9a6ae9bb2b93089df4b"
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
