# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.42.0.tgz"
  sha256 "a7b9092534555ea4ea0ea79c1333afd088569eb5865b941a4a610504e387683a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cdb43774d1bf066dd7deafcf7bcb550e4d000450cc022bb21144a0bfe305f130"
    sha256 cellar: :any_skip_relocation, big_sur:       "edb07f672e7df9f32995c7f5eb4aa98992633a0c13c9049cd4119688f4e805a7"
    sha256 cellar: :any_skip_relocation, catalina:      "89f76ee609227be5bad7528302cb5627652b29d44adec2713a8223454be44f9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "868625d5d315fceb86a09f0aeee4d9ef1e02b50f7105696f45bbf2eb0e51c282"
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
