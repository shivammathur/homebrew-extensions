# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "75e9ed564081cba82fc6682af6e01f1364d5363d1aa8c13f7b022807e3b83eaa"
    sha256 cellar: :any,                 big_sur:       "a386296a200b51652d6505846fdd25278efe0e3e697cd1cfa0802513a12865da"
    sha256 cellar: :any,                 catalina:      "4d155d910360e804fd9ba4c7e6e75a7426b9eccaa0f8d26c0646802ea74e721c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bcd89e3c751fd8a2a2f416008dd3e653bbd53ff9127faf4e4bff5a33b7b0e980"
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
