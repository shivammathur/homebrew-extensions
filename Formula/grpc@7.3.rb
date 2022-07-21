# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e4900a4c9d0175dd6f5bd0025787ebf6a5b0f512502b6455fad0dca1c5f22342"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b7506a7e838e76caf07c653fef0234e47e7c07adb7a92339fa92843dff4dfeb4"
    sha256 cellar: :any_skip_relocation, monterey:       "e6d3c83e168853c54899030ef435fe51fe0ddf3dd46f2f6dcad65a2a58fadf27"
    sha256 cellar: :any_skip_relocation, big_sur:        "7991ee26ff73f03c1d3f388a69a4dce168825d32aa8f20f26e68b9d12a2c683e"
    sha256 cellar: :any_skip_relocation, catalina:       "445b5f7ddd45638207ff6e3011a4d031387b122ff85753f08db83fe3753f075a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9531320231da21ced5a0d74509ea25ad30edbbf950ffe2adb963566bb34b0e8b"
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
