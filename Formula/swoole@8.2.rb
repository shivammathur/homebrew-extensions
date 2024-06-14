# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.3.tar.gz"
  sha256 "dc7a24094fe86025de4a0fed2a94005d2266a29332e7e9e6be50238a8ef6cafb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "a375d8ecae9d98f5aaaa0ea33cd5055abc3afa008e28226955603a67c2240f38"
    sha256 cellar: :any,                 arm64_ventura:  "c086ed1d62906d8542a57484ca163d3c6aad3bf11df0503b393fd22820b3c7d5"
    sha256 cellar: :any,                 arm64_monterey: "44b1029d4fdb19f3fac24c735b9a77ced989b367092b28054e9d573bec2d2e65"
    sha256 cellar: :any,                 ventura:        "035ddb5a62ae4d8d185ebfba5c24eb287ed0b7f5d5e0c7149c80d2f5e9a9aa64"
    sha256 cellar: :any,                 monterey:       "d27cf752333afddce3a3b74bce2bc48fe83d8aa0cd42a24a652bdaf3805abcc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0ef45e8b4f21bbccea2f8cd7900735d9a36a4cd1605652e1696a6f94522f9827"
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
