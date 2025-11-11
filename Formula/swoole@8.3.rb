# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.2.tar.gz"
  sha256 "240d9ab8afbd18fc50f7f5f3b98127a9620f80179998e9337423e554e4d59a65"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "1ac37623e110f8ae1e3c169a5dcf9b9d260658159ec9488df2df4e6a608d32e1"
    sha256 cellar: :any,                 arm64_sequoia: "8ce36387c7bdb3f6824a67efca1e416cf7490fffa89fb65fc09c07ac858bd372"
    sha256 cellar: :any,                 arm64_sonoma:  "e17c81f09b3bbeca847931a409931ece7bb841cf1986f6149433d450fce5575b"
    sha256 cellar: :any,                 sonoma:        "598b23d3faadce735f269f99bb41ae89b94e14f5c75b52270c3d79cc81382c48"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "412a84dabe5248d1862a0f5cfb9afea968bac09e81ee034a4559b50bbf382974"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd0ba2ab50835508efb66e99d08f4722cec46be2e8abf1aa27e24285ed249e8d"
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
