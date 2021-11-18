# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.2.tar.gz"
  sha256 "2b817f04236363cec6fb79e62df7838f2d885dadd569bdfb88d62d3792ddcca0"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "8cddb44e2a9db96469b6eea52f22d96ba291e464cd49cf30dd6c3fef97c49792"
    sha256 cellar: :any,                 big_sur:       "64c22842085b7f056a9890d54317b62af24f900e3a076d6fc9471aeced857917"
    sha256 cellar: :any,                 catalina:      "0352be9f13270a928e1b30b7b716b2bc61ca935e4976614d9ad9fb74058db38f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5cb613e377c112086d225d7cf2463a78cb712b1d2958b3fe21b97046e0403e96"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
