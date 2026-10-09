# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT84 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "4939bb0390ad95861e7f98c279df41a7a00ca21fc94383be812a5163d63598e7"
  revision 1
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256               arm64_golden_gate: "82b3733fd8bd967bc3ef2032cf0d244d2d80a8b0a8e011eca28798713309ae7c"
    sha256               arm64_tahoe:       "640e53d61bcf55bbfb4cdfa81d09dd38ee7025b79bdad611b2695d93be66a12c"
    sha256               arm64_sequoia:     "7db7cb4e33f908b28451c0bdbbc4e890d6a2352590fcf60a1c7ed1b0d96b815c"
    sha256 cellar: :any, arm64_linux:       "2a5e6673473e059ff4c5a5ce2de7c47f395fb17b779e1278ebde1360be7e66eb"
    sha256 cellar: :any, x86_64_linux:      "d27e26a253473cea27c47f20e4f25b8b0a07b81b32fb51ac6a1212cfe792451a"
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
