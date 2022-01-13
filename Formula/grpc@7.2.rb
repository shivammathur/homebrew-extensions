# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6b475ac9cd560a5e2b9718d23261ea69f75174d3e3def33904063ee54c574ba8"
    sha256 cellar: :any_skip_relocation, big_sur:       "fd421acc87846c97f568fab252c980092a4c6d39a47432a1222e197b083f25c1"
    sha256 cellar: :any_skip_relocation, catalina:      "d9773d1b091171b56449a86f4af4d4f8b5263afeb6b450e664756da1203e3a09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a9eff0d96a5b36af7815f53e79e46d62e3f8da9fa871d847b70ba50e9f4f76f0"
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
