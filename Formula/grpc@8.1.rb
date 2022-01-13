# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "32490c9a806b6a6e600f40e93c5d86d735748557015cc00d506d3dc8699c3af6"
    sha256 cellar: :any_skip_relocation, big_sur:       "e4362f76732e0fe35d1e9f6be9317cfec97fc0b9f94937fd954466c2d0366535"
    sha256 cellar: :any_skip_relocation, catalina:      "d06d25312741ad7bd887727d2606b76c810895a9db84be3211fc3289d529d7ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "685b42ccdeb882692d47703b4b724ec746aca685d785d9c722811da5a64294ce"
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
