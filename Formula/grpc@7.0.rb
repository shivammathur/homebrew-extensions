require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class GrpcAT70 < AbstractPhp70Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.31.1.tgz"
  sha256 "dcb3d3f8dcc87b411e18ab3782952ee417818ea0b3df01ac109c4e7629470d97"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "2cd6759f136d5d49c021f70635b4a010fdafc00dcd3e59ab209abdf72826ebdf" => :catalina
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
