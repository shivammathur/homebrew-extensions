# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.41.0.tgz"
  sha256 "62d7320d7e26db29254bbc5770b70ba1f902952b9c6f89d34461019e7f8086a2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4f84885d2cf4437e43b4a7a1f2a93a0c2c0eb819e4e55c0f09d7d1c9602248a0"
    sha256 cellar: :any_skip_relocation, big_sur:       "28f33e2f8dbfa262f292d0e246082da9dc379621ad91f9f2e3d3b07b9da9a641"
    sha256 cellar: :any_skip_relocation, catalina:      "6ef48182294b4a5e8c15cf4284ea047350146f3c0f539418e68067a6338c3f08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4f925357ed6cb11512ff5053311cffb887ba6427a7d068af487ec5f718f23a3"
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
