# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.0.tar.gz"
  sha256 "c8e447d2f81918811f93badf1a3737695e1c01f4981b5eed723f005af41ba2ca"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7f22e6d995c6607a0f09b3fb6db696dc631f3d64105af22aa6293a4f39d885b7"
    sha256 cellar: :any,                 big_sur:       "1b80b4a7fcb3b1b61e075d86aa6a87001336ba6fd06bbfa6abeaef702de5a2e0"
    sha256 cellar: :any,                 catalina:      "83026ed163eaf61051946e23e5f30f801cf9e24b9a86f87a040bcd635f35b229"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c3d0c3d9ae6b806f8972444f9472519d2fa4147f548189ede957984243c9c928"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
