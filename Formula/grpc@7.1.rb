# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "af001384a49cdbce7aaa87f35d19025a308d1debf79c999d204f2d1ed63b1411"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "42d5c2487f91ba9d6252e85f0a8a144874498c6b4cfadc899d4d40b717d23f4d"
    sha256 cellar: :any_skip_relocation, monterey:       "00f1878919a54a2f7fec34b7171d2e601b6e025b18031c13be8eda62447c661a"
    sha256 cellar: :any_skip_relocation, big_sur:        "1d72f18455f6ead0cdbc6e36551f8e8e4031bfe504ff524418a403a0737b1ebc"
    sha256 cellar: :any_skip_relocation, catalina:       "d9a87f0d0b950b8c82187ba14987eb9a8939c62961c5c178cb13e5f23e7a8b75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f00401a63d947fb7a00df905853f72efdc9856b985eadc7b4877014dcdef478"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
