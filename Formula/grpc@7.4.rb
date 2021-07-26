# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.39.0.tgz"
  sha256 "912bd2d2bd9d5b6e2ed861a79316a14811aac6f8e1a93c82dfc993430639d004"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cac3780bd66dff8f3772e4a8e823f5d574e2e84c8b754eef2a5d9e4b8d3a5272"
    sha256 cellar: :any_skip_relocation, big_sur:       "0df3127a809f3d661997dcd8517f3a54f4cbbeddfe8a15c1492f7642b6172e5a"
    sha256 cellar: :any_skip_relocation, catalina:      "0270af10be713646514d676967315394f2cb3eb52e5614d0309e8b2d3e188eca"
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
