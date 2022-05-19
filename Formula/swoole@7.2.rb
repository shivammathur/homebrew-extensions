# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.10.tar.gz"
  sha256 "0bf908cee05b0aafec9fbbd3bf4077f1eeac334756f866c77058eb1bfca66fd7"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a7ab59c3ee3318d95d31ecf8240b3a8ba657ad50f7b89ecd85f98bfdda9f9450"
    sha256 cellar: :any,                 arm64_big_sur:  "26891828cc920764949666aff52cc5739fa2b28cda53e492f6f20fd07d936b50"
    sha256 cellar: :any,                 monterey:       "7de847e38b67db000ff5bfd5c7b071544a1b6315619694448ae4ada061e8ac99"
    sha256 cellar: :any,                 big_sur:        "dd7245d023ad8f31ad40c232cfb67566efd65a5ecabe8862541a5206bd25abfe"
    sha256 cellar: :any,                 catalina:       "6ec392fbfb641dece16e4f5670d4f84bcba69745e9994b93f54bc33dd26bab7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f712cdf29189ad9097440cefce6db5eba09177d90f8ff2ab4975db547536be6f"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
