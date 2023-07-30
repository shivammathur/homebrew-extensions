# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c544f45a32bcc9ea659b1bbe65643893beaa7ece9421540a13b689af02f140d5"
    sha256 cellar: :any,                 arm64_big_sur:  "87225425c8d19535df6507bcccb039adf69730e7c91c48fcda84c1a59fc4df58"
    sha256 cellar: :any,                 ventura:        "cdf4870c858691ecda51682a3655dbf46030d76a958e5fa9d9f97f52e82a44d1"
    sha256 cellar: :any,                 monterey:       "c3ed9f1e68442e4362d780787144faef468128602765d84f3448437e660d7a62"
    sha256 cellar: :any,                 big_sur:        "d84c61713613eb4a2d9ed6112b29075b20310fa61a97aad0faa5f6c62bc956f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b0e1ff946231feeddab9641206bf246af687e69b9f76878be12e450fa9106b88"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
