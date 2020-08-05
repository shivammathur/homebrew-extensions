require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class GrpcAT71 < AbstractPhp71Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.30.0.tgz"
  sha256 "7201db290ce5083deb1e74076432a648deaca80224c5e96398bce61cb7c76a67"
  head "https://github.com/grpc/grpc.git"
  license "Apache License 2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "2b94c634176910450ec9d36b6fbbf45f6685293a3032827536fdb8ac1efd052b" => :catalina
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
