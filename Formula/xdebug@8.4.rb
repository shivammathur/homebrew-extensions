# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/41f0ec6509b37e967771cfd8b133dd6e2631e842.tar.gz"
  sha256 "0f48c6a099de2bd01f1bb9385af1debd99664d6dd82d56a3f4b668676021d7d0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "93413e93b0f748e1b619397b2bd8fc3244c553ae659d2973f83c65394fb2a8c0"
    sha256 arm64_ventura:  "8a774290628d483d4f952b8ea74373001d3a971ba612b000e52c277e5668ac61"
    sha256 arm64_monterey: "ffbf31306a89a1173bc39e78fcb608ec66457c9146a3dd421098131151a9b3c1"
    sha256 ventura:        "34d100d578084cddc48ff44efc2044d708e072bf32d8c86754c8ad605883ea1c"
    sha256 monterey:       "ecc638c8e9094238a9bcc0975833cbd5dafbe5fde83098c7dc6e10682632eae8"
    sha256 x86_64_linux:   "2c7076682b5cdbac10fb6408cbaeff6ce9e12b32116164c14e5571a89fbb0dc0"
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
