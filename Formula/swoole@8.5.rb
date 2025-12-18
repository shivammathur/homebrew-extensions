# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.4.tar.gz"
  sha256 "96e7e5c72062c797c25d547418c7bf4795515302845682b7a8aa61596e797494"
  version "6.1.4"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "dd695093c3c1a425e5ef735c7dac0a153b6afb0eb870fe84dae94c6a080a0fb3"
    sha256 cellar: :any,                 arm64_sequoia: "e422ca37056def92aecb6a7fe0ad9b5e064743d8dfdaf88a6de3d0824ffead4b"
    sha256 cellar: :any,                 arm64_sonoma:  "6dd6b69d41cceb38c8521289bf52f527bbf7896075c16d29a760d8e2d080eae5"
    sha256 cellar: :any,                 sonoma:        "13255a4b821ffb88df727a42007085af699fa4a3452835c52282cc55bfbb71c0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3cf4475fceccb5198619f05ba03ea8316f16ce3dce34923dc242e0a72443334c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "68d05fea7fadc68a954acd8480ec4c04fda1269f20ecc9717bdd2d1e8b886a48"
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
