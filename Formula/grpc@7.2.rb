# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2743edbf42351b17d38d2036277294524a238b13e534fdfcff66a65ba19bf736"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4322754e6c39537d50fbab92b6dd549fd58d113b77d4413d152c7a6039f6a8b9"
    sha256 cellar: :any_skip_relocation, monterey:       "95c35ae67a1d0e7af858a633d6bd4c1eb066c23a78045cc792a42c9914e0d943"
    sha256 cellar: :any_skip_relocation, big_sur:        "f800c584ec8056aa03084f781844099a8af87a8b9afea783959013d8521f90f0"
    sha256 cellar: :any_skip_relocation, catalina:       "6c3e059d5fd2b71483863e1c9f1471393727897b2863934635dc31302e34f876"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fdb932dc5cf73b3f2dda08004de9cdcd51012f23fa53898704a0fc2d90a6ca39"
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
