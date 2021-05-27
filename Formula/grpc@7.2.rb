# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.38.0.tgz"
  sha256 "4bec8f981b7b074ed78bc42ef229dcfb6c5fe3782f29bc4980b4da00866d47f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "efd3d777afaab662a0bc866e554b4d45e97c351c14be38b4f4bf70225dce15d8"
    sha256 cellar: :any_skip_relocation, big_sur:       "fddcf1ec78920c6b54dc1e91006ebf6eb26249c1b2f275925878bb96c1b84db7"
    sha256 cellar: :any_skip_relocation, catalina:      "a16cf4e6aadb76389d2e512728253379af03de0305417c24af75d753dd80bea6"
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
