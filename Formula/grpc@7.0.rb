# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bf04eb9a244d8f940d3ac6346655fc3d610e8ee29d059517f7983262878487f0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2d19ba70edaeb123d278521c72687bd8a549a261ea46a0c9894195171683c136"
    sha256 cellar: :any_skip_relocation, monterey:       "6526c466c2411ac6513b5577a63858a70962d527cfa834ca3a8e6a4fbee4d732"
    sha256 cellar: :any_skip_relocation, big_sur:        "25d252803da6164d419e67e6a045217fc2df6473c669ca5c47e16f2b371e9a3b"
    sha256 cellar: :any_skip_relocation, catalina:       "cdcab91fe95c71f96e6dfa5dcddb55dee91a53f4e408931985c9db62fba3e6f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f2bd0b998a2da9308c561ca2e9b4ab6f2e6c486913dc1ad706e74dcdcf6084c7"
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
