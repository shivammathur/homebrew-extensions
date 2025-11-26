# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.3.tar.gz"
  sha256 "8f1ca615314f7dc0d516fd95d68484b62b330de61861fa50282617b4e62a22f5"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ab408958216960b24bae835ed33142eb33a0164a57d4af735ddc78b99794ef09"
    sha256 cellar: :any,                 arm64_sequoia: "175c0b50f9b828c49f822db416e14bb4bf185bd0f4e9b5a904baf4b060130c23"
    sha256 cellar: :any,                 arm64_sonoma:  "520113bef0e117b58492bba013905d83f716df85de4ea9edf3850642f8402d2b"
    sha256 cellar: :any,                 sonoma:        "015e5cee240a8bf4927a65eaef428f05e67b37325a234ee725c997f35346a941"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aa9b4412aeabafe74784013cbc69043b518615efe8e71bbeaf5bc682803ff484"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bfa14662be9dcae107eedda8729e1d377cf864d666182b3f769a65a3ef365061"
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
