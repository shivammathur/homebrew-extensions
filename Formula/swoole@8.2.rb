# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "30ea319d8463fec8dc0d77f00ecd5b7ef22ca21c77f004cf8e0908e5230cfc98"
    sha256 cellar: :any,                 big_sur:       "821914a68749003f4ad69e37ae0ce92f2772bedd804b80a2c387835c828d4754"
    sha256 cellar: :any,                 catalina:      "6c8003a950d95fd58e04e78c9f26863c348d9a4f90b6fa67eb5fa23a79f7bf58"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aaf33a969e9cfd8441ea244cc1e1c3f0782d67e333b2f2ae2988738b64e9e1ce"
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
