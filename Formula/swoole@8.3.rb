# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.2.tar.gz"
  sha256 "b0bd47292add791b3bcebf347cd593c98a71c098dfeb96d125193bc95e95ed2f"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "cda659a882846bcce771dcd9b0f973fa12cfe8f02fe7dafafc0569b4327a4176"
    sha256 cellar: :any,                 arm64_sonoma:  "0c33a7068ed9f62fd4d5af2387e12560387885720eac1e401dac387ff79a7afd"
    sha256 cellar: :any,                 arm64_ventura: "b29a99f1e9c166419a4ff741e88950beba43929fd52c2ef81cf391726df0e432"
    sha256 cellar: :any,                 ventura:       "bf428788b831a2844fc44afc3d9b119a1421748a074f61725629355724682dc0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e259385364b31f92a12c4d8fd3c520704e49f1a2c2579f91e1a420e08e68968"
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
