# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "10d7f3d22ed8fae3ba98268908b99bb80bf1087a799048ba86581a8492e8d504"
    sha256 cellar: :any,                 arm64_sonoma:  "24b4395534c28a8b601227ba5015b34173a25f8577613f6914c8e41a1bd66335"
    sha256 cellar: :any,                 arm64_ventura: "f3e55c60019e31fb6580a1196a8186879597beb0c4df6420d4ec239cf23d0d0e"
    sha256 cellar: :any,                 sonoma:        "75b831893cb120d241f5d6ee6b24637adc86a2412b6349d12861f64fa4e1fb02"
    sha256 cellar: :any,                 ventura:       "354a64df14b0a84a3696116e0e6611f484077b5a75a73a840ca8b072bd4d779c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e37995a0efefbb026df45613ec48581b657f840be91f85d492baf01ac89503dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b94686936c136cd8679c298ce9609150f6fbc48c0af03afb3a0cf59b85aead91"
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
