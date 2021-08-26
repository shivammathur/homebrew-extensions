# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.1.tar.gz"
  sha256 "0fc700c8ea65ecf5247c7394a49b1f211e4a419987dd50adc0b0eda4ae1523c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "88afe9e7ed74fc831f8caaa06b74bc771dbb08ca05b7f632783211b84bd1eeaa"
    sha256 cellar: :any,                 big_sur:       "b80ac8e0e7f488231217fb8976b8fb75a5436436229a9a941630aacc45f66912"
    sha256 cellar: :any,                 catalina:      "4ab14eb3acd746b8aa6064c75d2f1fc2ff1c2b1be9b8a7e7aed27df5581b6d63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c46dcccd7085078730eeb5d487d5d05c2cba682919427a13ddbe4751b59fb64"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
