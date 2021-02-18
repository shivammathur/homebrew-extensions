# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhp71Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.35.0.tgz"
  sha256 "d8de1ad5df0bc424699a44133141d9d9c936d3803ae01e5510350590b8c1e4ae"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "317c2aed044a5d639b4747c73c044daae588a273aa91b2c8bea0ca287b358a3e"
    sha256 cellar: :any_skip_relocation, big_sur:       "b41e14600c0848a49bb760a3046c7d834b344c1f1323950a6678254b73147248"
    sha256 cellar: :any_skip_relocation, catalina:      "386674370fa6d31814f5f212293d3854154c1cab7c8a44cbc5a2cf6b5f8c5408"
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
