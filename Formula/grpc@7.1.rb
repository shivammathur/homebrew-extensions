# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d0658ed6ca28c293e0801d1cf664e9c9e074829fe5f5ed743671a8a0f117efe4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6588395f1142e354f3b094e7569d6ed3aa417efbec7dae40fdfc98f8576af850"
    sha256 cellar: :any_skip_relocation, ventura:        "515ce64131f226a86512be3d13f82f0e615454b1f847415a876b6f9a534dbd95"
    sha256 cellar: :any_skip_relocation, monterey:       "1e746cb7390d57df94e9838422e6026aaf17efc2897975f681d625918fb2897f"
    sha256 cellar: :any_skip_relocation, big_sur:        "baed74f839afe05d438177aa097ecf23667c72db8a00b61721ba53d61b738495"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "da2f674608a09356f117d3931abad1f432aaab318706c88a42d2ffbfaa8f0881"
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
