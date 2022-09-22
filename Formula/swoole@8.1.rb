# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.12.tar.gz"
  sha256 "ac0f5b3cb9ef2e04f0325fd4d2048bc727d545c56ae9d7525c9150b33ae55b7c"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7bb65a322b0733db4574fa598469f82bd709ce63c6f1d773656e1ff0737603a5"
    sha256 cellar: :any,                 arm64_big_sur:  "3366aff987106b87824c21577e3585e7d02691ffc9b4a0bf5db5ebee782125a7"
    sha256 cellar: :any,                 monterey:       "c72e9204b6bd2936528488e73e1707d49a4c0fc2f007c186ebe536c3837a7812"
    sha256 cellar: :any,                 big_sur:        "06d085d96e3ab1f7812183408b1a5b07269ff4e6ddea7c37f92d356981212bd0"
    sha256 cellar: :any,                 catalina:       "d0b685e321f4008db17c452df3f7a1af405eb7e7f396983b10df4a4fff025be6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8b6324691f21e2924e3a651fcd8364da46fd5c3cccdf89e532066bcede556b15"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
