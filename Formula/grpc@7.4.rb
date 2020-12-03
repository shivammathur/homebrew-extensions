# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhp74Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.34.0.tgz"
  sha256 "70a0f34ac30608e52d83bba9639b2cf6878942813f4aee6d6e842e689ea27485"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "284c97ef06030e69320a31c9a39be62898fb9724d1a2086e02584e175e97ab60" => :catalina
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/grpc.so"
    write_config_file
  end
end
