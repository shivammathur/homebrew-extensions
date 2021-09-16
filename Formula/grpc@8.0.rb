# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4aceb4c0a59287c6ff0f32909027de42510932f659502a1b2d1e0fd8fa6c1662"
    sha256 cellar: :any_skip_relocation, big_sur:       "e43d75dd9184e0388f3428a776aeb20ca9d2b4a7c4f174e91437ee46e7957fb3"
    sha256 cellar: :any_skip_relocation, catalina:      "fdf6decf9435f4b6a7a5c7420eeba4af75eac5e07cf145e8ddc2ea777f40cbed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b23afc8bfe6150c4c53f3400cf6322900717dd3147f279a55eeea0ab9933b6da"
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
