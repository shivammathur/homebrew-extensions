# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.4.tar.gz"
  sha256 "07845c2af6e25cbbf73b7e9aedbc5212e0be6cf93fec8274310ccb8b0ff41594"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "679d89febb53a1616c71e756b9f51d1422f0d53509302cfd50c5b85743bcdaa1"
    sha256 cellar: :any,                 big_sur:       "89ebff93fb7d1402f98573f74ff1a787f9b94efd2b95b959a4d6f7980a851813"
    sha256 cellar: :any,                 catalina:      "2a8e420357713519d5f5e6c7964c6a15471bfd4a8b69911834ea556ee2f3eb91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50fd7ad0ccab33ca34cabd8d38c9bb0cba2a3d068c4f92ba351c0b81d4e360c6"
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
