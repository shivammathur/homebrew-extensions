# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "0b989fe13893d8de222dff04afb2303f2f307d4a974355133313eb74cd70f8bc"
    sha256 cellar: :any,                 arm64_big_sur:  "388aef9da91c8f4e6110bd3fd4f5ddf2a209410d043eef792d3fcc05e95b9aa9"
    sha256 cellar: :any,                 ventura:        "ea60f484f98e9d36241cecfeefc65fe3472810107681e80a2f6e8b2cd366856e"
    sha256 cellar: :any,                 monterey:       "af057302e2e7f295bdd54c6b5d98080da42cda81672a2092ea86c14785c3c880"
    sha256 cellar: :any,                 big_sur:        "9761b5bdc140140419c4910a5a8d759b26ace785af7b31c51a47a3264297c296"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5723b4d5c5bdbdd3db9e8aa51357a0f9410105159dd5b9ae88bcba0e397edfde"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
