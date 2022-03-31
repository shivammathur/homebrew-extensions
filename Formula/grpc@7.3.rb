# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.45.0.tgz"
  sha256 "48f9c408167cd2c5df5d889526319f3ac4b16410599dab0ef693eef50e649488"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6892fb65873f4f02fac640e92f6097975bf72d6d43ff54043d9bb6534c0907ed"
    sha256 cellar: :any_skip_relocation, big_sur:       "57d32a94e3d4429d3ec0a4de0275c7672a1f3034b7df6edfadbc046b1f8390c2"
    sha256 cellar: :any_skip_relocation, catalina:      "cba5a20fc40247cbd96f185e08a9927cbd6c248cc933248ea34b6f5fdd80cb52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "919c52499efdb77f886b44a2b22e65b5882a2642fa101ba510377b20db62d64f"
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
