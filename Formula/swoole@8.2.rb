# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.6.tar.gz"
  sha256 "7f022cf6fa2f273915fd09f94ef019c50efa06b0be01eaadcb4b289d5622d77b"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e6fb47a5cce1148dccff3b36af2a3fd02646e83c5be8fd21c17b530440c359d5"
    sha256 cellar: :any,                 arm64_sequoia: "053e34d63cf3980cecdfe9de2e13cb3b55e7d44b2b32692ce7459493eca6242a"
    sha256 cellar: :any,                 arm64_sonoma:  "1402503b80fda48f1e73fdf74cee2c4031a50458c9332af66724c3f1e0e1da5d"
    sha256 cellar: :any,                 sonoma:        "2e5989fc9b8b8e8618998aca3e94cc4db88f801fbcc0679647a3c4ae76f1952b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "72d55f66646588cccefc4b483d56df505cc7e07072eb051f594768c5fa9b6c25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "af801780e9e2baa1eb6e985fa04d971ad249c6600604640b6b505c50a1c1665d"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --enable-swoole-curl
      --enable-http2
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
