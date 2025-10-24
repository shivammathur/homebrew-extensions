# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.0.tar.gz"
  sha256 "a174426b446203a5ea093c82687a7c952bc70622469a0a8c04e7317ab05f5dc1"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "19fc3eea0d3729ac5f09c5b557509e5f28318c85e7a97a9f4260a98ff5e6f152"
    sha256 cellar: :any,                 arm64_sequoia: "9b4f7392e13e8b47266852941290450c08614f6578891a02b71bc7440d7d448d"
    sha256 cellar: :any,                 arm64_sonoma:  "0459c4f2192bbb873fa91085e2fc86d60f0b3fc0e8d5d42bff7ef9e1fa9731ba"
    sha256 cellar: :any,                 sonoma:        "67f8fa36997b9d4a07ac3ca331f455259cac611ba09a8aa6628395133e135d77"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ab727f23896f3aa237a2fecb802d70954c7c0d20f10d9f65eec663e417214033"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c6524c6771de72bdd3559e395f1d9251828bb8d66d68f5e453c51c237aa05f69"
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
