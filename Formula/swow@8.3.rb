# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT83 < AbstractPhpExtension
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
    manifest_sha256 "50444897df540ae3c6f969e0fb748fcdcdc4b0613379b070e6ddf6b98abac769"
    sha256               arm64_golden_gate: "5ce6a12e4c64a2954726a3428020f7716a223753cf57b0d3420789311de4823c"
    sha256               arm64_tahoe:       "db88ed0a872564e02ebbb8474ff826965415723004f57eb4de276081c5a768a4"
    sha256               arm64_sequoia:     "78fb00aa7aa2d53aa3699e52a947bcdf923e41e78888430db4bb19d4b6f4ac89"
    sha256 cellar: :any, arm64_linux:       "afe66c2e65f88d29a9b52f372e81fe72591ff67133485a1198b5522ce233cdb3"
    sha256 cellar: :any, x86_64_linux:      "0a4659e4b590f37f4207ff1d0347e7e662f508581e09e0b986a78e9b7cff876a"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.3", because: "both provide swoole-like coroutine functionality"

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
