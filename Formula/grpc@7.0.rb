# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "989637b02ece68a054205a431e9cb65b1fe6828e743aa4d31fa175c7af5c8edd"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "01d856c360c4748743b3e06754f675d65a60ea755dc9f1f93e079cc6f1b7ce7f"
    sha256 cellar: :any_skip_relocation, monterey:       "d616616d6be66bb0e071f6ec63478b83484a151f5c2900838bfd12429491d497"
    sha256 cellar: :any_skip_relocation, big_sur:        "9653a25222471ee2e7dbda6e9c0cab87d4010bc14fce9adb3465db9704303ad9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ae2b0e6c293ddf741d2cd07b5ada3c3d0ec3d2103a2920530a7da91c6ed06b0f"
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
