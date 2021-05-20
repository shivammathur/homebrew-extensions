# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.4.26.tar.gz"
  sha256 "45edfdc1121773505505556264edf70eeeefb3f971dececfab35c55bffea104f"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "00c342dee205b96dd7f9fc035ca937d1a71b8b51e151e26fb040739f3ca166ea"
    sha256 cellar: :any, big_sur:       "9f91703bf69c6b7221099276b2eab1409f20d2e877cfde81e80f0602ab7fb12d"
    sha256 cellar: :any, catalina:      "aed428d8b12dc29bd772d51be78b08a34337e7af032f2776944c1961ea753487"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
