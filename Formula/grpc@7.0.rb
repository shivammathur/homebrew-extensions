# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.52.1.tgz"
  sha256 "f8ce3ec8ab3678c70d57fe60982dcb6562a6cc162718cfbe74783915b49803c4"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "761997a16affd59c54f673701360f7447b9f32bfbc8db0b5945923e7c711135d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "feba5fc31779678de7f71f868fb84b7a5a95d4bd9e84d52275d7e85fbc7f2d16"
    sha256 cellar: :any_skip_relocation, monterey:       "812326f095b5360a4ccd6a605de51f6e802b8c90ed3ea15880d1f7609f552492"
    sha256 cellar: :any_skip_relocation, big_sur:        "2b535e5437d7981edf6b356eab5f1021f480570e63d5f5ba0dce1080d0e10c73"
    sha256 cellar: :any_skip_relocation, catalina:       "4fea2be448a3e51b001abc0757f8bb02e466901847da9d3f5e070cbdffac78b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a996883967cbfe4c5c212626ecc9184e6d86e84d0b0d701c3dd60b0e381ff6ba"
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
