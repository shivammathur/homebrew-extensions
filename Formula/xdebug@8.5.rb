# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/c4178c2416399d1aa64a028a2ad908646dcfc808.tar.gz"
  sha256 "670948192a41c45facb644576763a715f45705c5e0410420d4660a200b6c0f1a"
  version "3.4.5"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_tahoe:   "29b76d2b7016651d5a09fd982267f1fdb4816cbce1b1ca7adc798ccf4d486275"
    sha256                               arm64_sequoia: "c9531e58328abd6a92b192921870d57859380f4094e790f939851757f07eee45"
    sha256                               arm64_sonoma:  "cccecc8e828fbfba56efc23297ce695af3c1314e9613148fc6e53e2180e14584"
    sha256 cellar: :any_skip_relocation, sonoma:        "f09eef3dbd46026866a151054f526ceb42d5dd0b12012ff528352c639ff77b26"
    sha256                               arm64_linux:   "569acbd0c2c4c278fb233fda09b3aff0475fd363e382728a9ef675f577be1f7a"
    sha256                               x86_64_linux:  "cea2dca7be769e2e3d474c3e84a10c21ec5410d27b58972b56b80f3091616b33"
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
