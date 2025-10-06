# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
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
    sha256                               arm64_tahoe:   "9fa4c7e024cd96ad81b03395edd0cadb07f1bd9d33bfbd867e6712f3f11d35ed"
    sha256                               arm64_sequoia: "acfd699b6953753f506ffc7a6588222c63d295c030c4cf58032a432e16b46203"
    sha256                               arm64_sonoma:  "6677909456a2c9c06532dbab7f2ec80f190a46c687d9ed5250ed2fb3ee2a64bd"
    sha256 cellar: :any_skip_relocation, sonoma:        "de81c0b71ed42a9593fcbd724201abd91c86dab19a6a4504803525a51dc8c93b"
    sha256                               arm64_linux:   "07f968452ff8a316834d2e1966f47bc4fe8ab0df9c9d33ba8e301391f6e75e17"
    sha256                               x86_64_linux:  "cccfe068e953beae79b0138fcd0b29abd0e9f3ca215534a4842cba54ff140269"
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
