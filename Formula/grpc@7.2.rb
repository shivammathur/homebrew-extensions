# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.4.tgz"
  sha256 "8f892ee4996874d389db1bb332324bd337e2420471262775e702d9222319fc0c"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2803652f424280d37188ba9c415c94b9a9fff30f5c064d7aedffa21921966363"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2ee2052f2833220946331b801b8aa4950112f98c0c1f0b8d1e515132d38773cb"
    sha256 cellar: :any_skip_relocation, monterey:       "088a522ff7b7f4b1d901fb2071f5cc3462b596951c8fbeef3f3f191ef046e478"
    sha256 cellar: :any_skip_relocation, big_sur:        "5f8d7c30e5d4901f20805849864b36ce8210ff76eecb7675a32cb427d4c483b6"
    sha256 cellar: :any_skip_relocation, catalina:       "b18b5609d2d0a4ab83f802e019d2913d5526548ee642623ea3ec375a6d83dcea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8e63e894aa8ff91df2b1c13f877eb4b88ba1519eefa83669de639d800991e0f3"
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
