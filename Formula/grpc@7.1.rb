# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "774ca23b2e836b1d3968a61c8eedb2cf18c784686ac660b3d3263ba5a7a332d9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5ba315ee316c3af5e49ee464830569f3b0f0bfa68c92c1f0d5f195ea7e30ddb2"
    sha256 cellar: :any_skip_relocation, monterey:       "347a18da71b84a320ef391fc26fbae2cb6a963971b7f6f8453805fa85501f26d"
    sha256 cellar: :any_skip_relocation, big_sur:        "586bcb52c7fed163c9cbbbf66b52b291517b5db0dee17a1e0fe83d4849c6cf21"
    sha256 cellar: :any_skip_relocation, catalina:       "8123e071d4e56790bb5fd31b7f10017d7ba144b77728cd21ddbb73a005ffdcc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "41632c9bc15c3fa3fbf1db6b2de2439d77796dbfef7455dc28c7d365f217ffa4"
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
