# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.2.tar.gz"
  sha256 "b0bd47292add791b3bcebf347cd593c98a71c098dfeb96d125193bc95e95ed2f"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "64c638edeca2f2f784f4b312f0ac3c9fa24b6f716ae464b2cc1bfcae8d771da8"
    sha256 cellar: :any,                 arm64_sonoma:  "0a069d2cc8e3a7b753d2da8c856c41dbddd1098f9cfa3bae2a8b3b00385171a6"
    sha256 cellar: :any,                 arm64_ventura: "35fcda8dd8972f665ff2f71882389b5245337f33ec7377daf849fea2b8300d58"
    sha256 cellar: :any,                 ventura:       "c15315801cf3f62769844f905328ab54acfe2472a3051a54ff12aa83520ec49c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5b9ebbb941295b3367a145f6eed53b4711d607d427127189a3385ea790d1bc50"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82aa995c5e1ecb738fc0814f0d76cb881972108c67f29560a2bac8d45452d3a8"
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
