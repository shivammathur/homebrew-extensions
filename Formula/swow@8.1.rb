# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT81 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "8f59d07e59fbadf72d623032d7923109010589ebb77a482f8ff625cceb74daa8"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "02dc8d5358bb92323c3f579746e66f3c5a050597c603dddf3b802b1d480c506b"
    sha256               arm64_golden_gate: "076eecbea9658557e221b78322bb63f1a6d00d5c756c16bef4bad92cf00d4126"
    sha256               arm64_tahoe:       "8e4a4da34ba84310afd2aaf09fa651e31d210ced073791db5875f3f2284ccc20"
    sha256               arm64_sequoia:     "0e63e2aa5fd1615e1d1ac16330faf1c9ba932081f6036238c8b0db7d5ec615b4"
    sha256 cellar: :any, arm64_linux:       "7a1057016cb7873ed244643f7e03b70fd0c2c63786dcbb280cfeefc3ce3334f7"
    sha256 cellar: :any, x86_64_linux:      "d1cced51a31e98da1a816503c63fcb485be2f5d0c312485e756fcddaa9d25372"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.1", because: "both provide swoole-like coroutine functionality"

  def install
    args = %w[
      --enable-swow
      --enable-swow-ssl
      --enable-swow-curl
      --enable-swow-pdo-pgsql
    ]
    Dir.chdir "ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
