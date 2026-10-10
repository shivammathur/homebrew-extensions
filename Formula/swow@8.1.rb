# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT81 < AbstractPhpExtension
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
    sha256               arm64_golden_gate: "2a88cf1dbc04036085a0c847a2cec0c90be8a7d3dc137da93df39c1d17e8198d"
    sha256               arm64_tahoe:       "e5fad652b58600b2687be83e87fcccca3d059943cfd6885499cc76d0bd6c0893"
    sha256               arm64_sequoia:     "336546a223a4b43e8ce6f9fc4f87274aafedaa0341af770e0f62ee7ccc95a56c"
    sha256 cellar: :any, arm64_linux:       "3e1f96b3241fc09559a5bb932a346ec709cd33734c6d3ba5717b3f27eba635f1"
    sha256 cellar: :any, x86_64_linux:      "ab1de39258897eeef0c736db50f864cfe6cf474945314b60f7870d352308e469"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.1", because: "both provide swoole-like coroutine functionality"

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
