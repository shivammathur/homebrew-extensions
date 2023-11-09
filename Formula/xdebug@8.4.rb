# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/ea6e15410d7cf41f8bc18bc779c1e266ed9ccdf3.tar.gz"
  sha256 "c5fc61571465d105b49de8b4814eeebbdf840266f7af4bd66fd9bd25b47920f5"
  version "3.2.2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 arm64_sonoma:   "96ffb503d9eed28a2f112372a84300eb8c642866a638022c2aaa2e5a374d22a7"
    sha256 arm64_ventura:  "4c1d39f1823e076780b3bca245213888b712dbb7d4d0cb4c2d9568b3251c3cff"
    sha256 arm64_monterey: "11ccacea524debe9c6f8d6d6fc9c986719c7c001594811ace0d54ae7f77c532b"
    sha256 ventura:        "2299ae016e69654416f3b102bfa2450f6944bdca98aeec5e6b70b2cc38dac1fe"
    sha256 monterey:       "982709a35f2e6773050772f49a0a3fde9c38271b3794cc8d1dbd94a714e7258f"
    sha256 x86_64_linux:   "98f98b44796a4b1d48692fb52ec61273bd7c1aaeee10cdc119ce83c29190c4fe"
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
