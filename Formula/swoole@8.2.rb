# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.9.tar.gz"
  sha256 "d859bd338959d4b0f56f1c5b3346b3dd96ff777df6a27c362b9da8a111b1f54d"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "cc8796f4e76b8f72d6dd93a1a37544b3be1a151bef8d6216146b2bed77136d91"
    sha256 cellar: :any,                 arm64_big_sur:  "59762369bf42cd0f3d2fddf67069e60279eaab1a452b11a241714da22a020038"
    sha256 cellar: :any,                 monterey:       "934808f1accb42137eb5f89889cc05a85f337da7d4533c2113874b050b72fddf"
    sha256 cellar: :any,                 big_sur:        "6934b8bbb5973a422762297f810bb7a0ad65926431f4db8962b3413c70e46069"
    sha256 cellar: :any,                 catalina:       "98f08364e56c1b445150efb1a90282ae9b6e90040cf6649cbe5e8b7c74926a19"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9ac698271b33699a230995e8ea8d1c81698dd980b7b4cc3e242bb812c6907c89"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
