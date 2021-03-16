# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhp73Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.4.tar.gz"
  sha256 "fca3337a269db0533c0c7db10b48aeb9e6e5d7b84188d17ac59576b3f365fba3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "76660c6f5d5223bee431df1682b24ff817856ba61269ed01a2e29e81f8998058"
    sha256 cellar: :any, big_sur:       "173e293ee804691008c133645d22dd60137489d68aaab289751ea98fdb3d4404"
    sha256 cellar: :any, catalina:      "a44293660fb42f8cc1641c2447e7aa5fd7a4dbfc0a9734961104bcd262705020"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
