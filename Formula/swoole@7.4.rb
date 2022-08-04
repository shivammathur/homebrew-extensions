# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.0.tar.gz"
  sha256 "460ae95865af17bdd986720c775b3752cedfc27c2b0efe96cc28ff24d5b1ffdc"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "69e2b60c1cd21e037ee8c53aa5f32ccca143a128ecf5fd800b012e3af3332751"
    sha256 cellar: :any,                 arm64_big_sur:  "9b95f7b7187d3791f3e93100e96b781e5118c80fcd50c620d1dcddf3f6a996e5"
    sha256 cellar: :any,                 monterey:       "0c5ab4a1271209dc5b4c39d70c3a2e74bd4740dd202c58e4adf9591b163af40e"
    sha256 cellar: :any,                 big_sur:        "aa6b5e7b8a7c835a23a0e00f343f9c75589ccd1e35e235ff7151f7aed61bdcd1"
    sha256 cellar: :any,                 catalina:       "37f528ac90fbbafb4c311fb8ca31c8b1eac2a6b9252cd24b675cdc51ef0e1162"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3e4d0fb38ddba7ae743bba8d73a4a5cd7a950fd376457f1c963efe3c112e0a3f"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
