# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT85 < AbstractPhpExtension
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
    manifest_sha256 "38f7fb1960f31b1af27c8a3b0d8d58e7c0bbee01780222d1ae7ed3b214cc8690"
    sha256               arm64_golden_gate: "b045dcfcc67176f6c4b663ed405381bc43a7cc85a5c7d4a176c6327c1d9566bc"
    sha256               arm64_tahoe:       "2a07238acfcac4882e0f884324722fc5dfc064c6e8129f75111963237eb3ea6b"
    sha256               arm64_sequoia:     "f09ea0f9f8962c5ab9ecf396999735abd29e14415492195c86083dbf65760e94"
    sha256 cellar: :any, arm64_linux:       "1c242d99ad40d1b2986bcceec86ed019810407a125b961dd28ee89f959f0d64a"
    sha256 cellar: :any, x86_64_linux:      "0b06734f962022d1bf41cd29e8960d36bdd0248e64f2028a33b2b0d62ca3aee2"
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
