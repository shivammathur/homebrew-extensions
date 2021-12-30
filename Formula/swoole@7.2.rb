# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "4200f749fb6cd5a2d8399120d73d3a7688dcfe3fa996cf5901edc7845e0f355d"
    sha256 cellar: :any,                 big_sur:       "c49887b713b35a9210ca02926aadd30d44febd3eb0993774e48430c3938764c8"
    sha256 cellar: :any,                 catalina:      "e65a39e1b5a0439a196e4680a73aa4ea943c310c8bad95c2068ae6519099e088"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f84efa571803edc780b9d225a08e043af413038cc3df702dfe74765b4468aef"
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
