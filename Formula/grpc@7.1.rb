# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "365d9e8b38f4d316acd1b0974d39825cfedaf927432ebb966a10059b78ba2539"
    sha256 cellar: :any_skip_relocation, big_sur:       "9c28421890c5d3a0fedd7c730c1e25376f833681aa2e3378d28250b8a0dabe17"
    sha256 cellar: :any_skip_relocation, catalina:      "d93b250132594c5f47c5ced577c165d8db5e67231d204e34ee74d236584f7a66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14ca1eb57054001f2687fd90046b30fc6ef159edb8a5d98388897ea2522e06a7"
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
