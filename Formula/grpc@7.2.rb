# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.41.0.tgz"
  sha256 "62d7320d7e26db29254bbc5770b70ba1f902952b9c6f89d34461019e7f8086a2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "de4c7a521b1f1f49112db34eda2129cdf387a8473607f2993e7b57e2e7b1864e"
    sha256 cellar: :any_skip_relocation, big_sur:       "57de8c3ff02a92d9347d4aa527d04c72f00e4222b274cb5b62e4ee529e5ade94"
    sha256 cellar: :any_skip_relocation, catalina:      "5c95f020cbe707b0d2bc0ef867dee4860116fff99e37e0a5d5fe4f53d84f73aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "69e320badd0cee475c679c8051deb75132ca82de85c6ead6486bc2ef3fdcc62c"
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
