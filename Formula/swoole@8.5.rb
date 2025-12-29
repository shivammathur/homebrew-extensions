# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/3944e51fb4d9a9878298b48cc6ca23bd790013b2.tar.gz"
  sha256 "7963db0a9a2e470f1aa162f6fb13209f0c823a34cd08525c441e53e6c60c04c6"
  version "6.1.4"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "71bf27a234bf4f23658b98178f117664728200c392893582e8283bfbafb2e077"
    sha256 cellar: :any,                 arm64_sequoia: "d0c516868eb725f8f6eda78051198555a89efb71b37d13ac74ee8040137d2eb1"
    sha256 cellar: :any,                 arm64_sonoma:  "e557d310dd109fe6b5af257488d5cf8664e33ea1e0dc4caec7520d65a55b16aa"
    sha256 cellar: :any,                 sonoma:        "bd23fd2148517f1a034a40431d78162c08ef897fa3b9ed682d22a72f7586a6d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0d3dbbd3e37e5aac12eba5c6ae02045146ae831afac956a159b313641290694e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "519d14597ed6ff9cf75949dd3eadcdfce1e64ccd2c3c823f800b5591c487ce3c"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --enable-sockets
      --enable-swoole
      --enable-swoole-curl
      --enable-swoole-pgsql
      --enable-swoole-odbc=unixodbc
      --enable-swoole-sqlite
      --enable-zstd
    ]
    inreplace "ext-src/php_swoole_private.h", "80500", "80600"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
