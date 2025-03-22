# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "f8bbbfead0ee2fe62ba315ab794b91bbbcede8c70af142c36ba7861a5b294729"
    sha256 cellar: :any,                 arm64_sonoma:  "c954d711386fc982f12b4bb130cfe0379b7160850e324899ae13adf4d9b75f69"
    sha256 cellar: :any,                 arm64_ventura: "4725931fa8df7f3edcb8aa07d0268cba23580b4e527a6f4b4939cf51e77a28e6"
    sha256 cellar: :any,                 ventura:       "bee3671b5a65d23253077b3274359ec51163dca6381c22b4c58cd2b68899d77e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b7d9f0930c8b9d503ae48b7f8960f850906c21ae46cde42ecb7c84462bc13c2"
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
