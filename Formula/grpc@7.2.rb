# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.45.0.tgz"
  sha256 "48f9c408167cd2c5df5d889526319f3ac4b16410599dab0ef693eef50e649488"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7b8bfc7b7761d9f781716f879d5e666e3ed2c4059422209488b85b13e8ff900f"
    sha256 cellar: :any_skip_relocation, big_sur:       "2badc48f812794d8cc9a27edd8d36469753277a832a6cee2216b310a13bcdd8f"
    sha256 cellar: :any_skip_relocation, catalina:      "282f2df72face611b94ae522970dd97eb64e463e405ec0a3d76900aceff777ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1217847dc8a4634d9d15a5ce4454efcaa3f89ded5a1bb2e5ea359bc04774d3ab"
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
