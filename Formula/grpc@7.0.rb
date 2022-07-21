# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9bc584f25361977b04af7f0462bc626642f55d987425a28b9f2b00d9f04b01c7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "03584af5efe1023a1fb1c85ed5b8d3b85d18e7a63a620d896efaac4ec617ebd8"
    sha256 cellar: :any_skip_relocation, monterey:       "862cfdff21ba2f06ac34e81ef9a1f53aad48db6060d8e49021ea3b04c5a28eff"
    sha256 cellar: :any_skip_relocation, big_sur:        "fdd4ad1cba3a04a2e8c3f4a9fbba396319d0f8348b04db68fed751f81704c23e"
    sha256 cellar: :any_skip_relocation, catalina:       "9b080906e1abee091f3474e37fe315160f9185f3d41a9d3f319a7527f80d0861"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cbbe6656bca98baa4b1017e67275706345acf493b2d713ad6104447e63806493"
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
