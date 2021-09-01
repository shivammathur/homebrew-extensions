# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.1.tar.gz"
  sha256 "0fc700c8ea65ecf5247c7394a49b1f211e4a419987dd50adc0b0eda4ae1523c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "8a1b7c7db71f81e326c11b67fa735c48558562889de7063edf69be6d0917d147"
    sha256 cellar: :any,                 big_sur:       "8c1f3275ec2419626408610d78246abb7539d97e7326630bc9004bf174f7c1e0"
    sha256 cellar: :any,                 catalina:      "73c22ccea97d704a565ba1ca98bff6b8e02dcd68a688171de9e968c052ca61bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "594b901e84b5221d378d5e3a130020454d5b2d0e4ed7b17125c04915ebfcce2b"
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
