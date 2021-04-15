# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhp80Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.0.tgz"
  sha256 "591317e428276a05ca578dce778d4ade47d777a1efa9509db4dd480f82a5e822"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8d710a2122283f3471b1c0569bd9e32654a00b8e6ffc90be15806bec862929fd"
    sha256 cellar: :any_skip_relocation, big_sur:       "2172bd971f625f798cfa9bc0483ecb2545a1f79633ffc8de76bc4c042616a48b"
    sha256 cellar: :any_skip_relocation, catalina:      "a318227e6b4761c8e43003ae63650eb5a0fc834deced802b8264b902ecef1d59"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
