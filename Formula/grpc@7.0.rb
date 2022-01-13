# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cf152cee3978962906b8f69de3bfe0f0adbe1999ec62074a97fbea1df6ee2b4f"
    sha256 cellar: :any_skip_relocation, big_sur:       "8a1f381850ff36aa9ae156998f41a3b2e65ec6e1a96a9d1c6646e72b17f1ed7f"
    sha256 cellar: :any_skip_relocation, catalina:      "cf19d67d291a9e904790a763fe06a7ea1bf607e3975bd56de3522f5b09fd0de0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b0354c1e5174b8d91f01debcd61aa3504ee41e562ec1a6bead555954491c411"
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
