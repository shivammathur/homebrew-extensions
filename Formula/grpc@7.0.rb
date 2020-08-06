require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class GrpcAT70 < AbstractPhp70Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.31.0.tgz"
  sha256 "41039c346f239ec50bf591f3417a1f171b269ff589dd59b39290d9c8b5be7afb"
  head "https://github.com/grpc/grpc.git"
  license "Apache License 2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "49a7d1c2d472c45a77f86de6b9806f9b1b90221959d24ac45f3819ac6ef61885" => :catalina
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
