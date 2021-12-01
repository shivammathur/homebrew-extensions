# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "844738a6b0c95706a33b3f80096ab7dd33dd1485a81f64d0f53f1a470c67e126"
    sha256 cellar: :any,                 big_sur:       "8edc90b5e01e1efdb0c4b7d6d4a195561ba6c2fd1ab8ad5f11c03c9075ed17e7"
    sha256 cellar: :any,                 catalina:      "f4e0dbab54428886fd1f18906f1bc92733b31884b03b836aecb0acc967481218"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2df13a6522bd9161603798f54fd8392d41919a71db0538b5ba45a3c22f0de2e"
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
