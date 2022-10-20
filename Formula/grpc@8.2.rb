# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2245751adbb66cb034156fe1e26cbe3da0bfa43fec6d1f2bf545b2eb65e73133"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "24bc0f53dde4ff795ba34c1d5971027834b1650b4368ce02b140b0157297cdbf"
    sha256 cellar: :any_skip_relocation, monterey:       "db2f4a4ecb9f5d06e6050caade1e26aab9be334ed6bf006ed45bd927286ed8d4"
    sha256 cellar: :any_skip_relocation, big_sur:        "3b3d83adf1ec51363154307206525c4f9999705f782d7bef324b35565a9d870e"
    sha256 cellar: :any_skip_relocation, catalina:       "f54114d542242c748f2a7c9d0342505b8b368787a632cc0efd2ab663febaef07"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8ace32418ca375f4ceac07e2dfc274c88b3c52b0c86bd710f5e905625f2fd467"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
