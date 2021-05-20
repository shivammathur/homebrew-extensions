# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.7.tar.gz"
  sha256 "f64bf733e03c2803ac4f08ff292963a2ec1b91b6ab029a24c1f9894b6c8aa28e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "61294a124968a129ec61f5ebb7e4e77cf9e0ab95449d00243c64189a223539f0"
    sha256 cellar: :any, big_sur:       "07465162b352117a0d1597ee8eb77aca3c43930717202d26aa2d222d357ab1c8"
    sha256 cellar: :any, catalina:      "a89ccc3886d62adb54dfe4f68ecb3244e347453366a8632ae934bcde453d87ac"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
