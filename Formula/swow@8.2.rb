# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT82 < AbstractPhpExtension
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
    sha256               arm64_golden_gate: "b6be8402f3ea58c164de24a25c515ced24e31bd82764bad802959be5c0590cce"
    sha256               arm64_tahoe:       "136df6bc0ad682b4b34a50904a2e3d766aabc041259915a5449044e280559104"
    sha256               arm64_sequoia:     "e22833ce062f9377b248cd3a34f5b20eaa26f4ef8b224d7b2bbf5bd44b5fb49e"
    sha256 cellar: :any, arm64_linux:       "5784c723f2c76047492612bb443724ff930b070e18a3d78331ba3bc6ce4aff1c"
    sha256 cellar: :any, x86_64_linux:      "100edefa9115d24a6ef9644fce90398912afb002926e7aff9e11d09bae34a58c"
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
