# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.2.tar.gz"
  sha256 "2b817f04236363cec6fb79e62df7838f2d885dadd569bdfb88d62d3792ddcca0"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "3ac5a1a061282880398ef9eb88eabf7b43e54bbdc12c74aa8c5151f66d9e56d7"
    sha256 cellar: :any,                 big_sur:       "e277dbfea80fa5a8cfbacb1ef4a8c8ecf55135ef809661574c92e7682dfa10b7"
    sha256 cellar: :any,                 catalina:      "eafd6409195fda8cc3fda732a84af7d3ce04a03ac79824f437ba23ce7fa431cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "440096992412766553310f94976e1d6e121309c73fc958f9a081308bf56105fc"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
