# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "1ba18ffb456cb0273b36e030e60f8d9988e9379cde3c3887edec0f427001ce89"
    sha256 cellar: :any,                 big_sur:       "8dc15139071fc05a17a9dcca880b431737c73730e1ea1ba1af410afe17551135"
    sha256 cellar: :any,                 catalina:      "f25fb07d74817de06f682ac7230431d9dfcca91de3f21be82689406254c46357"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2333400bebf4670bfc4d3f1a41b14968910bd874cb64bbc23a0c398153827f21"
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
