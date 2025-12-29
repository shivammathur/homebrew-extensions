# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT83 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "4939bb0390ad95861e7f98c279df41a7a00ca21fc94383be812a5163d63598e7"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "99efd761d4ff3a51207c3a937fe756ff67fb9ec94844a0fe7a17bb85fba068ba"
    sha256                               arm64_sequoia: "26d796024d22fcccf9bd749a81e7dd4c3c10c2510b206362ff8fa39669b880b4"
    sha256                               arm64_sonoma:  "95ca84ed51a1d316ec73789107a0182f624b2afc8f0223707284d81cf9675c1d"
    sha256 cellar: :any,                 sonoma:        "d0b461f8cad34f5dba36d54ef7f0f77601192947306d54eec4fead0e97f0327a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aff294434d1a7e357b13a11617132033f20041c0600faee6998e497f4f28163b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5200c4c52b828a5eb1d8f1594c06792ff6c4aad5b49e2da4d20a7903bf9c984b"
  end

  depends_on "openssl@3"
  depends_on "libpq"

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
