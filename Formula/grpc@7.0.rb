# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhp70Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.35.0.tgz"
  sha256 "d8de1ad5df0bc424699a44133141d9d9c936d3803ae01e5510350590b8c1e4ae"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ecece275a58c84914b64e7c31c18c8729827d2e18996b65a8937a0a660d6baef"
    sha256 cellar: :any_skip_relocation, big_sur:       "5b32110ec6ed369953d48b395811e87e3635de610214713c7bdbd9f1833d3d7d"
    sha256 cellar: :any_skip_relocation, catalina:      "f625723c7561f444e66be6b1941678f3fe170d98ad24b7b1a2b71f991bdc02e3"
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
