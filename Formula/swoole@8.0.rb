# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b2a992497bbea9fb2caf8e903c5ca8aa4bfbb2ecf8c3881113ac1f2d538ac622"
    sha256 cellar: :any,                 arm64_big_sur:  "af7a7548f79666eeafa4b97bf85710376a75314b88feebd5f08dea92b462cbad"
    sha256 cellar: :any,                 monterey:       "b6f8e2b8677f33a58d6497f42de5861c84f04bf0919d1dd3bbc012581572ebff"
    sha256 cellar: :any,                 big_sur:        "1792a8618761fb659d553397d3e89d343a5f28de0e206191bbca1fbff586d826"
    sha256 cellar: :any,                 catalina:       "78390773d39b1aa85a32bf67dcac000d07812510abc544b32123313adaddbc80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d9efe28fd1b76c0fdbb70bfe83f47d9db6d1c1c691590d3dbe6b18c6678133e8"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
