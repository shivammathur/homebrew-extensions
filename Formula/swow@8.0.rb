# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT80 < AbstractPhpExtension
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
    sha256               arm64_golden_gate: "e7d86a71f13913140c7b5f4d637b4a8fc64feb9e0186ecd74ede87f22b8e1745"
    sha256               arm64_tahoe:       "a4598452d9b1bc1cd4ae0bce58d9ea62e36f387993b687e760f2278a18887827"
    sha256               arm64_sequoia:     "c33da04dc5a700a33e92f7bf42d2c0d6347b53c4f60a72673ec3cd5e0197c20b"
    sha256 cellar: :any, arm64_linux:       "f2a8c39349f54568e6765c776b31cdadef233929dc560a25afeaa66817a6a165"
    sha256 cellar: :any, x86_64_linux:      "773cf4a6091e9dc71ae020b13bd52ca4663da4727e7cfd0d1a99fabb562d283f"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.0", because: "both provide swoole-like coroutine functionality"

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
