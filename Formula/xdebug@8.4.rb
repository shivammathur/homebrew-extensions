# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.1.tar.gz"
  sha256 "8fd5908d881a588688bd224c7e603212405fa700dc50513d0d366141c27cc78a"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "ea7d12a752fdc8df32f2fb8c13902688eb82870829c73b4c12cb2fa7f5e26b40"
    sha256                               arm64_sequoia: "65f37e02efbcd7434502519db4aba60862e44bfaefd4d084a5b32492fc284b5a"
    sha256                               arm64_sonoma:  "bfa69cce988ac651b739c71906779096ab564f60053ad287e7820c087def59f0"
    sha256 cellar: :any_skip_relocation, sonoma:        "8773f76ebce989ae0411672c3319aee172ff843543fefc1cf3ad7fa8d5af651b"
    sha256                               arm64_linux:   "3315a5b1ea832435a83c2615ce747c48c15269de637b97b7aca618314fdda10e"
    sha256                               x86_64_linux:  "4b32ee3b98a5f75025e5837c64a48e6c6bdd664c92fc6496ef7d3ad3edea698b"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
