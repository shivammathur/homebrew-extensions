# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhp81Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.2.tar.gz"
  sha256 "ba0f95b85da77096c535e4919935bdcd07742641e9664b715041343c902807c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, big_sur: "f2ed86f66f30e774638fe67b05f7886308f43c7ccc947d2e07564931fd0c3c73"
    sha256 cellar: :any, arm64_big_sur: "598e308edf2bbcf1ea2e8c909a32ffe8b84ff4b207dc0523aa5f6fe0378157aa"
    sha256 cellar: :any, catalina: "e2f1e48c9d3266b0dfa72c0dabd224910464da09b6a7d221a8da06f547384b28"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
