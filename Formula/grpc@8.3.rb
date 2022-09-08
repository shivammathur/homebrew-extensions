# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d83eda1834498ab9f687478291b69384026118c543a10fabcf1fb464b78082d0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0aa879a5315838543893aa10e088bd1c01158b660aca74d081bac30ef89552a7"
    sha256 cellar: :any_skip_relocation, monterey:       "a7d6cae1d0abe067c6c814d07e909510b68f57834d242c06aa8303372e11d38f"
    sha256 cellar: :any_skip_relocation, big_sur:        "c114b876d4a4412377666308ed0f32e374e05b7385a8bc465d2dec7258917b05"
    sha256 cellar: :any_skip_relocation, catalina:       "f9005a9d32454d5f55ef0df79733eecd0485a08a6752d4ae6a52562e4e5fa22e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b2d6e515b7a5639da29c83f55350b457555a9884e3baa080ffa83b86e4a2c119"
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
