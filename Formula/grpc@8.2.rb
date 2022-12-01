# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.51.1.tgz"
  sha256 "a8a79bf27bceeb8088c2a3a5a76c1146bbbd3e8d7a8a13e44ddbcfd715213ba9"
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
