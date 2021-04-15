# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhp81Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.0.tgz"
  sha256 "591317e428276a05ca578dce778d4ade47d777a1efa9509db4dd480f82a5e822"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d351f5251dcd405516feb08e01e36d4aec8744b3d5382e01a05112770f41be90"
    sha256 cellar: :any_skip_relocation, big_sur:       "83fdd95ded7ed96dc6c526a1e6bbea788735d66b577d6579a2c763e60062eaa7"
    sha256 cellar: :any_skip_relocation, catalina:      "b51bd11e55980d84c496c83b4684ac6ae760d5eab7b157a95637d3cff4e21cb5"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
