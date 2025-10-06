# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.6.tar.gz"
  sha256 "4ac1a0032cc2a373e4634ec8123fc6e1648ca615c457164c68c1a8daf47f4bcc"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "a4d5e4a5b2d90a8fdc9f88206ee40207aab6f461ef40b6ed72e549647b2a45b0"
    sha256 arm64_sonoma:  "f236c7217dd684050de6bdacd73c05c6982f9197401b36e3e6b67c6e57fe3882"
    sha256 arm64_ventura: "d283de8feab11add522c15fe94342d16c318f969e9f547943a0b169258719b86"
    sha256 ventura:       "c85b6987673863d31814ee4e3724168525c307b961c7612ec0408e7edc78f0dc"
    sha256 arm64_linux:   "238c0e78239d0527f66f540a4dfae2fb9dead3b98a66e0fe0513299a80860775"
    sha256 x86_64_linux:  "2262da07e4f08f28f87f6929d19101604f4fed573094cc19120905126179dbe3"
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
