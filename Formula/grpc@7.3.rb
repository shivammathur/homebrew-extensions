# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhp73Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.35.0.tgz"
  sha256 "d8de1ad5df0bc424699a44133141d9d9c936d3803ae01e5510350590b8c1e4ae"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "68fc5680bb78e3f6ec7de78c2c246214eede4511fc7c668c559c612a23761afd" => :big_sur
    sha256 "7730a8709e9c0ee031254b2a8906d82f08288a61cb51ed980c7f8bd5ce854c26" => :catalina
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
