# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/57486fa8dad31de41c2d9c35d711c7f2e8970abd.tar.gz"
  sha256 "2b2160df79f7abe002730150fefb224c9d6a55471a34c080fa83c5e8dd530620"
  version "3.4.5"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256                               arm64_tahoe:   "f90498deec74dc5e94d703a0e2aaf8bb2a807af2c625e573739f4c1754561532"
    sha256                               arm64_sequoia: "f4fdd862d484cb745c50568e51bd2b586f88ff240d6f08f134dcbcd77fcf6728"
    sha256                               arm64_sonoma:  "82ef9d066078720835eab735213c0f504fc542e1e6a519ca80ff72e1bdd7ce96"
    sha256 cellar: :any_skip_relocation, sonoma:        "d17f80c1b0cc869bb6cf19d11fc50315a5ff980516c6fa92e9328c62a1915b75"
    sha256                               arm64_linux:   "bedb5586149c5670f1854d0286c25fb056076ea4fab5ab6d9f9decbce70336cb"
    sha256                               x86_64_linux:  "ffefd65c339440cc8a70e2732b1a7309ea9195e93aefa33c08aa7ed3a7a24dec"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/maps/maps_private.c", "xdebug_str *result_path", ";xdebug_str *result_path"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
