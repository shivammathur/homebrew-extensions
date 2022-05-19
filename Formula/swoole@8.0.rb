# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.10.tar.gz"
  sha256 "0bf908cee05b0aafec9fbbd3bf4077f1eeac334756f866c77058eb1bfca66fd7"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "515d829bacb165312933c1a74a180b24241573e627aaa9d8101830a0affc5fb7"
    sha256 cellar: :any,                 arm64_big_sur:  "c2c4539deb6b71e4deba3365e1baad5558c5d1cb952592384a3dbb998d9a54a4"
    sha256 cellar: :any,                 monterey:       "0b0f75c70530e5e4339fd16b9463c58c7ee4b78cf577dacf1a9f228ebe87d9fb"
    sha256 cellar: :any,                 big_sur:        "1aab4466a9df5fd18cb5734b290e00bf3badf2d4496577426060f13d2cd2a5ac"
    sha256 cellar: :any,                 catalina:       "cf60e7bd397eec46c26d3637850799c3b4f0474398ddf7a3c8a492248b57a6dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "db2d9a1679dfae2e9c396a9ac3a65ee2beaeb8a21406a620417c78cad66c702f"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
