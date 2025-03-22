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
    sha256 cellar: :any,                 arm64_sequoia: "564b4605116e6b42f4edcdf61c7582b1a765110ce4158b08cbd32c4292eb8a4e"
    sha256 cellar: :any,                 arm64_sonoma:  "baa76575b36f305d86645ffdc31e747470fbbe8e18fe5efb5a8526268b8d127d"
    sha256 cellar: :any,                 arm64_ventura: "944fedfd9f20a5b8aa444a0e164ca85e1e3c4baca288e33003f6c962c69ae736"
    sha256 cellar: :any,                 ventura:       "29eb93695732070116830a1b8a8556de5934ec8654c8ad1e50364ed1ea5a16a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "556a26e40dcb3561947bcfd3ad7c3207581475f6503c41aa456393542460b8e9"
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
