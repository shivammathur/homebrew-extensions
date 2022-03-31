# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.45.0.tgz"
  sha256 "48f9c408167cd2c5df5d889526319f3ac4b16410599dab0ef693eef50e649488"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "37a3773f9f79c756565d84723392d794ff70570a57fcfa21c2a16103638d1d85"
    sha256 cellar: :any_skip_relocation, big_sur:       "64ba31b0106b09fc22b926290b1d3d99da6fe382309cbe69f46ac5adc95cfc4f"
    sha256 cellar: :any_skip_relocation, catalina:      "092af89d3a3ef71180b128dd10c54141f69eb3bdb016a15f1dde5419dddcb98e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1bbac284d63d88e0f87d5f609a72b34204f93494093db7ec3a632b2370172201"
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
