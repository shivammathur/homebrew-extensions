# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.13.tar.gz"
  sha256 "5d8352521ee31ddbd23b46eccffb5c99f03af99c6d058857ecaf964c2ef433d6"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "3986b9d357ca918aa766f690297c1a891c1f0bf5b34d5d4fca45cb462bb25f88"
    sha256 cellar: :any,                 arm64_big_sur:  "d989983c36aae3ce66d2650fa401c79eb7fa69901d4b810292eef940a6845dbf"
    sha256 cellar: :any,                 monterey:       "b668a43154ddc5a7dc421efef565febcfc4e8abf2839e735ef5b954381843015"
    sha256 cellar: :any,                 big_sur:        "6a107f0e0d34b833471f82dd59acb2742b73fa2b754b8be46122ec3c4c1294c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0a377e98d1c1b5e713fb4081428dac835691ab07b7d7247ad399ac1c53cee540"
  end

  depends_on "brotli"
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
