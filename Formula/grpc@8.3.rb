# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.4.tgz"
  sha256 "8f892ee4996874d389db1bb332324bd337e2420471262775e702d9222319fc0c"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5eacfeaea75f6720ffe2b80b0ae22152753c41327abfe5a0423cedc2c8a8bbba"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0ccb1943e439ce0e1802f8861db92302f224347ecd2813b7d530e08f6de48989"
    sha256 cellar: :any_skip_relocation, monterey:       "d54b5e2497ef2dd53e46628e245567deacde9be5746147278128a31ddf97e513"
    sha256 cellar: :any_skip_relocation, big_sur:        "67abbe9682f0fe5606ceb0897161b2ba3c90aed8539b72f9ad4ccf257101fdf7"
    sha256 cellar: :any_skip_relocation, catalina:       "b3142371b3ee91c9bc938aae1d3bf9f15dd2a2e319153c923d3713caaeaf8f6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c0a3d4935dbfce870d30c400137cf133e52401e600e95eab91bf109ea43444e1"
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
