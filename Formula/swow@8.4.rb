# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT84 < AbstractPhpExtension
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
    manifest_sha256 "2b170f268908b03955d786e1f3281af0fddaea1866f63298771970fe9fc5d384"
    sha256               arm64_golden_gate: "e9aec348e87243f96402b290308986309536163d01772ccc2f7707659c9dda0f"
    sha256               arm64_tahoe:       "7b7091cd353823ff09b777e45c3c3d85bf7a3d9310743c4cad223ed22286f0aa"
    sha256               arm64_sequoia:     "b154fb40e2c300b5a6dc3d8cb9f7a49edb5fd505831bf9bd27cfb586f7f05779"
    sha256 cellar: :any, arm64_linux:       "62853edf897f8f5b3306a0a986c590ae145afb32a2e8b533cff3407916c6b194"
    sha256 cellar: :any, x86_64_linux:      "af995fdf3c4e6f723fd41899d7a07a5f1c0008906b88f73e55a8177c63c66135"
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
