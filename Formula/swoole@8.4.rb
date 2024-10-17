# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src.git",
      branch:   "master",
      revision: "c71b7d450fcad748316f2424b8602c6f2df20516"
  version "5.1.4"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "69f2094bf37b608b6e521a0c0bc97107265827d7779aff4134dc727ebcb2389b"
    sha256 cellar: :any,                 arm64_ventura:  "e793a1b1ed386392ef5aaa32b4d2908efc4a57eaae5d36781357c717e79128e3"
    sha256 cellar: :any,                 arm64_monterey: "59631e8af128268acfeb996a19dc298af4aee5d1c97cba3fde6860f1d8f439b4"
    sha256 cellar: :any,                 ventura:        "045f3cf17ad7d8d305525ef0fa9cf058ad3cf2dc82eac343dc1ecac3c4344331"
    sha256 cellar: :any,                 monterey:       "7126206d69b7f156df47989ce27a1f14caa7798a6c0822ce911252ac8369b199"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "133a267383055391501308406342b23f28430214edd2e1eb34dffc60178c97c4"
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
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
