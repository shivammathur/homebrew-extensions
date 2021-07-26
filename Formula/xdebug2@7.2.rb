# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class Xdebug2AT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.8.tar.gz"
  sha256 "28f8de8e6491f51ac9f551a221275360458a01c7690c42b23b9a0d2e6429eff4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "884c4d7ecff7a25a153b564acfd8ab56cd23d84ff6638ca2330157a39ea84992"
    sha256 cellar: :any_skip_relocation, big_sur:       "849db23fc149074d58772947adce827f8eb04b95e42dc8a16c109fa8b6f5f8f2"
    sha256 cellar: :any_skip_relocation, catalina:      "be532f6cf3d6037d28a6cc03154fc673920f1df41d559eb19ab69c67fe05dece"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c4cae7670f7dff92fb80750dc0a50cf02001b0b26ca0c1649fb5173400d170b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
