# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bafaa671e96e106071f01a5ac8e25e556fe4ac5a2223ca21fffbf99b8bbf5416"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "87381da676f0ee06717e7befa457d9d5babc213767a93c4cda5c909bebf3fd77"
    sha256 cellar: :any_skip_relocation, monterey:       "522c0ded146543caccd5cb6feca0e2272ca2132b90a552a983737c7c5d9f1203"
    sha256 cellar: :any_skip_relocation, big_sur:        "43aefda3eba68e48004ecda4908e5096831ac44fe47681e0170c7d65ddb04a10"
    sha256 cellar: :any_skip_relocation, catalina:       "8639ec1730228ba5edf92e497c60af140a8f89b31d8862bcea7e8724ea4efd1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6915b255da2688bdace48a30c5a74e02d1cbc2c56cb32162de1dc3f00036e409"
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
