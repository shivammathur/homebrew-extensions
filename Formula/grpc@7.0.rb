# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c39ece2fa1de8be6f968faa5b8875be215248bf604b8623c443773f750995081"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "491834f40790304f8e30c80f6f3f202c9ad94b62ef6b0e236ffb680b357adad3"
    sha256 cellar: :any_skip_relocation, ventura:        "5b47c6a644db466a8da3ce38e5d1f4a82760032804ca31f2b60f38809a521ade"
    sha256 cellar: :any_skip_relocation, monterey:       "91776c708ebdb79cae65beb3688dd5948a74b4b9bcbd695b93822ee666f02e0d"
    sha256 cellar: :any_skip_relocation, big_sur:        "3f72894b54f4fdb580943f0054487227b56a2c2438e288a14ff95fc683f63298"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8d645b0edf639a620a1d57540ce3d3f7f33cfbb9a75b0855715af88f3184405f"
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
