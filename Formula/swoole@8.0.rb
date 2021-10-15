# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.0.tar.gz"
  sha256 "c8e447d2f81918811f93badf1a3737695e1c01f4981b5eed723f005af41ba2ca"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "44ed050999b595af0369cc0c48f5da2ed8d0390209c2585ce7eefa34ec6884aa"
    sha256 cellar: :any,                 big_sur:       "a21c206d89f5872246c3a8122cb6bc4404e93e798843e6bf6b6932fcee82ef5d"
    sha256 cellar: :any,                 catalina:      "f589f883a239631e7efd315d9dc321cd0c7a310a284fec848cc95eea0a28f7b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4a937c5c4e8001d0f0df3e34b4b9d3f9500346fe528c81af584067a8d7375cd"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
