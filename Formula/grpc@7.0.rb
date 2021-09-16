# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e0b768616a26c741f0ac8c5d835a7432b39335057ef92f431bc166a069dafaa0"
    sha256 cellar: :any_skip_relocation, big_sur:       "25915bbe4229cddca1705599c8601df672a934dc20437f79884e8f1494ef3442"
    sha256 cellar: :any_skip_relocation, catalina:      "b9433c0b665dd483c28e456f22572ef2536293f68c3302d00be3933367da2b5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f180ac2301127247eabbf539434b052a2deb4a1dedfb42aaa75b4fd122acdf8d"
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
