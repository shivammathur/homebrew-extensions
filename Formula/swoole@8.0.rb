# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "2067cec6302cf2dcdc7879eabd02f800bb638afe1b334e2beffaf49dc75f5357"
    sha256 cellar: :any,                 arm64_sonoma:   "611037d8038f2d8dd5ec5ad41189c357b076f505893d9b49625d4e03e0656d44"
    sha256 cellar: :any,                 arm64_ventura:  "978b6a480588162d7423fc0b29da471b408d460451d513418ade007f9df59591"
    sha256 cellar: :any,                 arm64_monterey: "c9369def982fec8ab066b2cf11ed8f3a8716f371030b00cb20636e3df073eab8"
    sha256 cellar: :any,                 ventura:        "0c666499afd5f77a688c88b83468411b3d3a346ebb01b2d7ca96caa566e97881"
    sha256 cellar: :any,                 monterey:       "d4237b9628c74c62b2b87f789d075fa4121624b6699c2abde60e21e67a6a07f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0dddbca9a22b3050c942667606a9377f965dc33c6f4accbfe33a194a614cf6d0"
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
