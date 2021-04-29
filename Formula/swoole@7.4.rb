# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.6.tar.gz"
  sha256 "8cd397bda05da1f3a546a6c537b8896e668af1ae96af8b6c4b2bbf8af57c7dee"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "d5a8444a346c620c50b3f47175808f188372ca15e2efc1053fffd2a3a3b35f08"
    sha256 cellar: :any, big_sur:       "79a86df8c9ad69ea81a748e6e76c02c6cc21b7a31e5b2681afdc97561db4f642"
    sha256 cellar: :any, catalina:      "2dbe3ad1add2925a1bb6a9f9ac0dd659d6b180039ae75f557a04b1ca7ae0d470"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
