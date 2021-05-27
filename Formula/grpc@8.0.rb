# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.38.0.tgz"
  sha256 "4bec8f981b7b074ed78bc42ef229dcfb6c5fe3782f29bc4980b4da00866d47f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "debbfe2ab764e87fb1001f2f980cf5b6ab2ec6af497c1a18fc3c5726f6f112b9"
    sha256 cellar: :any_skip_relocation, big_sur:       "e8444a4996cf78d7ac15a9fb866e2b6eb48058d04d26180b3c6004f32721cc3d"
    sha256 cellar: :any_skip_relocation, catalina:      "c3d596f231faf999661f1133a3998a1b77a2d2673067323a78aa36167364d71d"
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
