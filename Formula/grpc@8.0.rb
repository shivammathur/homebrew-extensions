# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhp80Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.36.0.tgz"
  sha256 "819becd24872b95c52ad1f022ca71f6f5eed207605b19a26e479b1d5a62c8561"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7c3414a7b0f58dd91985231d85bf4b5a1ee5794b7dd393552abe9ad165488f2a"
    sha256 cellar: :any_skip_relocation, big_sur:       "bf7209c4a0bc7ccbee895fdfe8fc20e99528be4883ad8b4450520880e9b6d165"
    sha256 cellar: :any_skip_relocation, catalina:      "2732c3afec811fabadd49cec02b845f51d2d49dc87fc55f8d0e74f71f45ba732"
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
