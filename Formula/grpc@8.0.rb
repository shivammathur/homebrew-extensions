# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "14ca8035b441ac63aaad9c93729d26ce8f1424ed23295926f4220d335afcfb30"
    sha256 cellar: :any_skip_relocation, big_sur:       "7d562dd6ff61759510d30e7530dc43e97c7b9879737bdff827b3c64bc4fa2530"
    sha256 cellar: :any_skip_relocation, catalina:      "c34395e57da074fd4ce002b3e60dd1d8cc9506f2e5ce9526576d0960c3437558"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4171b9eae9def8876f7e537d071aef80606e0c5e7a99e897d45f94e35b5ac34"
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
