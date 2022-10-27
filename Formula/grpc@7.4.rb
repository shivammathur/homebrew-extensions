# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a58fb1d166d83c18de51eeb70143c8ffb71d5d258a031da71a60e36a8d10bceb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "92d5d9f440789f3cc18ac0336270c8caf53f2e1493ee45005c3a0eee2863a38a"
    sha256 cellar: :any_skip_relocation, monterey:       "0aea9e52530a9d1e70b1cb1a97595077af66563eac09f7e2367cf8bb0fce5534"
    sha256 cellar: :any_skip_relocation, big_sur:        "2c2d66276ef3ef83b72caa16c46d08b07ea503f91ec7301bbcb59fc4b0870bbe"
    sha256 cellar: :any_skip_relocation, catalina:       "827b27bd5991db2062d8588e359595479f56aa75d613083c8b1b4b0cbbc7faaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e281d56c7eb53ed7c05d519b8ef02f1023e333c753102f4f64c7a9262d9548cf"
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
