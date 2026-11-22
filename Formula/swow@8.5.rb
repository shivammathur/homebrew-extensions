# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT85 < AbstractPhpExtension
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
    manifest_sha256 "165046db4c5a89b772f879c90e82de7052bf2a22a4df91d9d2f71ecbd4bffa66"
    sha256               arm64_golden_gate: "5c76a2f035c209407d44d6d5e5a3e59ceac8656040a6fcfa114841d66250857c"
    sha256               arm64_tahoe:       "c31c7aee3ef029cfc4d668567cf5dd639dc576f7eb4802918acb43580e721261"
    sha256               arm64_sequoia:     "7ef2736598a10803d35d6609202ca64879f610d94ae0dfa855aa0d45e13097f1"
    sha256 cellar: :any, arm64_linux:       "ee8a9da44ee14f97d0e68332ba917d6c2639695ebe6b57205b1d61661dcee952"
    sha256 cellar: :any, x86_64_linux:      "2356f94c0654ab179795c0fc5f77cff367f0094c23c2bce7e90e98fc4e43f9e9"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.5", because: "both provide swoole-like coroutine functionality"

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
