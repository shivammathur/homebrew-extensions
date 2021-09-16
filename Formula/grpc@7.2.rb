# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bf0fcc1338719d3ac38492debb1c7d0fa863c493dbdf7cf99bee88f4eb918217"
    sha256 cellar: :any_skip_relocation, big_sur:       "8230c8bf7cee14684ef20f1246f97348ebbff0ed2d8d83223b17914e6c03bfb7"
    sha256 cellar: :any_skip_relocation, catalina:      "ab585c866e66969e9f81fcf9b881bd2fa0e50700084168631ad4a0fabc8a66d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3713d0a193a643ba3695db202df6f1670c1a415ebb70c1e70be31c51da5bbb1e"
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
