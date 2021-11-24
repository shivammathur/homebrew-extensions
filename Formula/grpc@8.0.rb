# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.42.0.tgz"
  sha256 "a7b9092534555ea4ea0ea79c1333afd088569eb5865b941a4a610504e387683a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "661388e56d57beed52cc7e48e2c0050339755bf9a1edc5fc4d0855f60bb0a8e8"
    sha256 cellar: :any_skip_relocation, big_sur:       "ef661ca2df6587e68fecc179043228e29a6cf77e31f30f25119fe9a370bdbb67"
    sha256 cellar: :any_skip_relocation, catalina:      "afd5545b2f0ff133f611e4eb9f9083c162be8f51c3e3cbef612ca61ae7466000"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8197d400f43ce996a7bb037a77b7fa90937943801d50b5a6ac29596ebebe53f4"
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
