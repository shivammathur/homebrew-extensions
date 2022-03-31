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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b02a9c0a196dce98aada24f8a3ebc1e25122a7d1ffd3016ce84c6aa27560d37a"
    sha256 cellar: :any_skip_relocation, big_sur:       "525ad936d771bf7f44702c1b5429f16281c5bd3726957de5626bf15cc9769d7f"
    sha256 cellar: :any_skip_relocation, catalina:      "8bced9fa99bba39c4aabb8bc01264ac398594c577da375c0d0e87f78d3e6cf25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31aef169e1b4784091dcaf580117343337e2743f76ed485c7d81ff4f6fdaab3b"
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
