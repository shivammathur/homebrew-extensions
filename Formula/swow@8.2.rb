# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT82 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "f8c702170e1f1deb9716e4fb86f69d9c07e3d73958ae2d79544a234443ade651"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "66de5ec117b97b06da8391809f5e40ab6744da45b87ea7c77565c0b71a7c26e0"
    sha256               arm64_golden_gate: "d6d322d51fe4368c2fe8f48b2c795d3b6eeaa33e7c7ef229a07ac363bcedd685"
    sha256               arm64_tahoe:       "3a46a0eafd3ed6cea62da76b27edc107e049ef493ab67104c24896061c51a4c9"
    sha256               arm64_sequoia:     "eec42ccfe7386c03e6435112e7e5e706990557ff21a55202a158cda9644b1c81"
    sha256 cellar: :any, arm64_linux:       "48f9eb7982ee8beef7619a786ca54735231dbeb2c4ad87ac01c4ec63334f8636"
    sha256 cellar: :any, x86_64_linux:      "8ec69d96dd1ece65fcc185fd21a5552b3b85218db9aeebd25e14414e7e89a98d"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.2", because: "both provide swoole-like coroutine functionality"

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
