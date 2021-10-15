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
    sha256 cellar: :any,                 arm64_big_sur: "957ed20229c79ba1e606578bd2b000b26ab6609d999f9055b2934115ae862c7f"
    sha256 cellar: :any,                 big_sur:       "f57db4ff31801a09c361fd25d2971c99996619df101c9ccb075a7302c0d40cb6"
    sha256 cellar: :any,                 catalina:      "8caab509a1a599be240e5d14072c6f63633c39cf1d07266a15cd700b490f5a9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4039ee84e739793f57cab57dab9dccd4f6c2c6363da2ef29828dd05883e2bba2"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
