# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "f80266cc1ece66ed84f04f6de76278dacc123c8e84d4b609f8c48f6056036ab3"
    sha256 cellar: :any,                 arm64_sequoia: "0df5bd1285c6653dc9f71134d4e3fc3f02006a1759fa375e193ddd05bef3dc45"
    sha256 cellar: :any,                 arm64_sonoma:  "53b0aca25d641e6d8b012ea29b2cd4e03f5cc40950b82ddd3205694d121abdda"
    sha256 cellar: :any,                 sonoma:        "e682310be878b0f0358d75f0008ea16f3402a5541034f9abf3f640b3bd20bfd9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dc119bc0571c25fbdc470e90d869c78797aabfe7f19b365b8a1bb8b2fd785db8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d08e91c51742a4fbaaf8fa0db388ccda6c61e37980f7b599651284fb03cae78c"
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
