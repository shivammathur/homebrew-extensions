# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b3ac6f9befda1a8be3802da49f37bb98636b3947757ed67d2ff0e34b96328858"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "99fe19c6fadeba60cef98786309084eb9f0aa174d16a1265b8ac390f738ce4c5"
    sha256 cellar: :any_skip_relocation, monterey:       "5655d8f93a4fdd1802d331dd5fecab6ebb928f1a52e4982b75ef656ccc6e5d77"
    sha256 cellar: :any_skip_relocation, big_sur:        "4014939677cc0b6a779b29afa119c01ba194063ffd414e8d4627bbe8db14ac27"
    sha256 cellar: :any_skip_relocation, catalina:       "1a82023a6b959535879e2f22a71efbd7ce976be663d6b676cc0fc086199ffea0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "742cb23e003e60965cd9220d395e0d6880d3bf75f82852d49a2cf4d171a9b614"
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
