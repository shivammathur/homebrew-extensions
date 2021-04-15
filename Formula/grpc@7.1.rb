# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhp71Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.0.tgz"
  sha256 "591317e428276a05ca578dce778d4ade47d777a1efa9509db4dd480f82a5e822"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a71c8f76214c5eb022cc761429fe9617b0e6d505a164f806ae444660b5df8224"
    sha256 cellar: :any_skip_relocation, big_sur:       "4ff12924262ae26338867fe73893fdd64661f262b8e5542c99ee5fa3aa8aa347"
    sha256 cellar: :any_skip_relocation, catalina:      "21b93690ce1ad4c3260cdbaafba46a4e0ee66b9eab1c3c4c680c6a5afeb7cc31"
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
