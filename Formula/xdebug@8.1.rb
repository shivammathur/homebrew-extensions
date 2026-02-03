# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
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
    sha256                               arm64_tahoe:   "af994a2f4f541c17d1a5259d0332fd049ae33443cd4373ece9a2d8f3842dcc31"
    sha256                               arm64_sequoia: "0ac733ffd6f5d8c3549138e668babdc9f565d072efe15e01116850230c05aa5f"
    sha256                               arm64_sonoma:  "9fa6f2b333bdc31b8fe96f011a25a5a400850750be9668433a806360e03fbb22"
    sha256 cellar: :any_skip_relocation, sonoma:        "b0b0a262cfa3ff26634282ce16037cf0d02c661e90df91b51b6aace2b87a44a1"
    sha256                               arm64_linux:   "922ed37462fed32c308013634467000d2e2f094af0c56f456bc46edbacd22fa1"
    sha256                               x86_64_linux:  "84129c474bf11cfb7a2c283a87892cf51e9b1ab191907609ccde065e8cfd6fa8"
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
