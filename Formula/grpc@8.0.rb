# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "28d8fe7c7cc3bcad604414ea59aab74f57cadfc36daf15f05e4dc40858c5e20f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c81d49a0096113b6f26466586675339d104713b60b64b1ac30e4e7a118f3f513"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f5303766d072a731e265e38ea82fd6944af8772eee4ff34b1813861a72eabcad"
    sha256 cellar: :any_skip_relocation, ventura:        "a16332d65135cbdd209d84e7b0ce69577a244bb371b2829efb99392dab5d6dd1"
    sha256 cellar: :any_skip_relocation, monterey:       "3cd53140af13a1728970c1304038b786f41247509fb7ae3351c6e2d8aeb7c596"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eefe275f2c38b609bbe6c8adc8adcbadf683ccb19cfb7fd0602b71ac9a9e0dd9"
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
