# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.42.0.tgz"
  sha256 "a7b9092534555ea4ea0ea79c1333afd088569eb5865b941a4a610504e387683a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ccdf6fe6cf99a0db1f2b14eca88480acf94ddf5d3cd9f39caa32063867c7ee57"
    sha256 cellar: :any_skip_relocation, big_sur:       "7ebd11f7f80a85b72f632991351ca563961584bdd0c0d746941bf971ef0e39fc"
    sha256 cellar: :any_skip_relocation, catalina:      "a3aca2c0d78942a1368acc75f923cdb57b66e4b769011e987d64c413e43168d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00b5362a0a33a784ac04b72f851c1cf77ce5a684b9aa75a11ceaddb092b03f8f"
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
