# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "298d0573223216c152b9f2ff3e290926e928483c3f8253330cdad92d93f079d9"
    sha256 cellar: :any,                 arm64_big_sur:  "c6afe055522f81be00f357a61408dc1cb1446542a23363eb647dd73f4265965f"
    sha256 cellar: :any,                 monterey:       "c849a77c9f18ff15c4c09494c118f77d451334acaa8b5ff10a78d6a128854c19"
    sha256 cellar: :any,                 big_sur:        "aa6f796d1cdbf9fa5bdf4fb881e14d19fbb1ee45915637a1ecc2a41a17816da5"
    sha256 cellar: :any,                 catalina:       "ad796ff50fb88fb973dd7e369a15138661ca7259a90d078c2a7e68a8a30a1a6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "37cf3acb731cdcfa77a48cff5e64308a94071e2e2de548c9b17ecad3df277e3f"
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
