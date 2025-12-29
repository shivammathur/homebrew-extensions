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
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "9dbd14ba623264f2da27996b58a6fea12166085b5c0f1f621e3cc38bec2bda6b"
    sha256                               arm64_sequoia: "cfbe90a20fe05ee941d7a32099eef762181c78364a42106b52fe8a286de52fac"
    sha256                               arm64_sonoma:  "21ae1d474914a08145a62eb7072ebb5af5caba5a07fde34f8ab5487e2b9e41f9"
    sha256 cellar: :any,                 sonoma:        "73ab7b048bc9d8aa2bb6dad24229980331143538b2503719719f1d49f00a2ae5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "288f1fa75fba4f8dbb136ef674c0a332d0ee73931acf6aa67cb15cdf8c67930b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5633e178a220f7db1d54381fdfb9595ecee5e06ed2c5adf5027f1eaa3ddf4fbb"
  end

  depends_on "openssl@3"
  depends_on "libpq"

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
