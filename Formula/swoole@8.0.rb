# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "264490e8b9ecf9ed357d4f953a95225f573954da6095d8e058bc61ba1d57ebeb"
    sha256 cellar: :any,                 big_sur:       "a239fe9e9825b7cf9c6e733eb9ca0bca9d90047f06872a0f6239936eac3c8919"
    sha256 cellar: :any,                 catalina:      "520d7b47206bc71cbcd8de2317511fbab7ee87bcc2eb8032b412cb85a6d60760"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c31dde97e1fc0edbf1ee970ca7901b0b8377f2bb6ddfd030f70745c7214d927"
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
