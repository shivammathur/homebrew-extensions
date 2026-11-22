# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT84 < AbstractPhpExtension
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
    manifest_sha256 "ae9752c98841de97245b0aaa2018673501d817552d80afb557821876a489d6c9"
    sha256               arm64_golden_gate: "8751ae804cb90abbecd11abe8fa32b50e251d32801130b7d676ba2509b2c0fac"
    sha256               arm64_tahoe:       "07bb3c1b2c4d15ef4c1983eed9c784cd714f873eeab09c225a5c000d6111d10e"
    sha256               arm64_sequoia:     "6b2396b890010e4ca7fd3be6c8c1cee48e2e381c5f3fce8171473cdd287f43a1"
    sha256 cellar: :any, arm64_linux:       "f785be93be78b43a42a9a5cad0a6c953b8e08857340628af2723daf0926097bf"
    sha256 cellar: :any, x86_64_linux:      "7c297d00eeae200869db70550ad075b1dee5a4be97c3ec6c9a93e25071d78ddc"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.4", because: "both provide swoole-like coroutine functionality"

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
