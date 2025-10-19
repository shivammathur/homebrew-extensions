# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT71 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.5.10.tar.gz"
  sha256 "164d1a712a908e3186fe855afbfcbc9ff7bbb1e958552b6ad1cc36a32a72b3ab"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 sonoma:       "0d434995b9841921b203ff641b18f17d9e3dee5fce1331ca71e245a2ddf718c1"
    sha256 cellar: :any,                 ventura:      "4fd2be586a50fb2a9f29bea1df0a7caec708f8777b8f03955ecde848a792bb4f"
    sha256 cellar: :any,                 big_sur:      "84fb4776677b790a593a9e2982ad443591c38586b5b25ab8aec70a33161bdde5"
    sha256 cellar: :any,                 catalina:     "6be59933ca33aeb7986e4ee12edc3fae3a4516e53dfd633aa47d24ef16a87e01"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "96b687c7e5c4994841aef893342d1773cfb7c42566e7c3b61a42455cff0d8542"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bfd4363d2c8efd31135eed4097b31682bd2e23c138560a821c7bf87bf0a483b1"
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
