# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dd7ace0f8cadcbe26a84fbfffccaa36edfb4b86304e5b466ad5779f000be6281"
    sha256 cellar: :any_skip_relocation, big_sur:       "b0ed680815d0a0708b4500745aaaeb1e01456fea2ed5df92289c4a9755b23c1c"
    sha256 cellar: :any_skip_relocation, catalina:      "8ff1404ff96d3d745f63c5b7b397ad0f112c71ca82214f1127df9f475cbaad89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "368bc0b2e0ae6285aba1f90e5c2be2c79ceb8241cbd4fa66d2f201bddd1dacb5"
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
