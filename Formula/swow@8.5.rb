# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT85 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "4939bb0390ad95861e7f98c279df41a7a00ca21fc94383be812a5163d63598e7"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"
  revision 1

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256               arm64_golden_gate: "12b2d0374d01cdf476a1258a111d957e45ea5034e620537d29f48221d6feff95"
    sha256               arm64_tahoe:       "9b5aa245d9bad18eb7d3c63e79eca31d70a5c1c5fca6cc75d2f958fb2f74b59e"
    sha256               arm64_sequoia:     "59ab519dea9e77035f472fc7452b0541669761fdfca4a14067f8d50815b8e94a"
    sha256 cellar: :any, arm64_linux:       "b0a781168e1b2e4f2d3d4971ef377cd7766976baa68d3f94e53b029d083a2e51"
    sha256 cellar: :any, x86_64_linux:      "973ab616324a9a99383ec919dc058604dcf5c09fe162f32bc10f539e3aba66e9"
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
