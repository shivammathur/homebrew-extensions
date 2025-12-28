# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "88474b8e2cbaaf8584ea1587f5468ca31ba110901515841f3523e844cf77d452"
    sha256 cellar: :any,                 arm64_sequoia: "cb2e62ad2252d6da513aed2c6a513aaa89014c4c63c5491708060b46720b0312"
    sha256 cellar: :any,                 arm64_sonoma:  "503568f97ff631beb60f179feca93fa6844886029299d6205f0ceef12f81b1e4"
    sha256 cellar: :any,                 sonoma:        "daf330b7506d76564ce3133b234675124f866750953d36d796520c9c7191adee"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "699393e6282945d9cf417bab816ff6edde81a5428568533a78ce4f1ff02d2376"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c02174b91ec0c2327b0e2df9ae2852ce46de1146130ffdc97aa0995f67ac64d"
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
