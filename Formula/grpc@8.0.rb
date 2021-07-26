# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.39.0.tgz"
  sha256 "912bd2d2bd9d5b6e2ed861a79316a14811aac6f8e1a93c82dfc993430639d004"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e5bb7fb6a033f6fd71297cad3853caf67811d9f990c34a53d7186a623acb6dcb"
    sha256 cellar: :any_skip_relocation, big_sur:       "50f7dd9e88546dcdba0f4352daf27f64fc8860f5cab9595f4e39b26a0c2ffbcf"
    sha256 cellar: :any_skip_relocation, catalina:      "1ff967d15704d5683f14767035a139a291b8727a6dc41e75292e24a4ef58ad98"
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
