# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.38.0.tgz"
  sha256 "4bec8f981b7b074ed78bc42ef229dcfb6c5fe3782f29bc4980b4da00866d47f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bfba742cdf8ff6d7393711260761baffe357acda1bf1bac30ab9c8231d9264c4"
    sha256 cellar: :any_skip_relocation, big_sur:       "d6b3bad9842d94c4c681da4bb86008776aa94f1b25e1b9bbca75187e7721dc38"
    sha256 cellar: :any_skip_relocation, catalina:      "7d84ff2c3a68e032d66d3111a2df47c028afb4968ac62179b9c31fa5b18287b1"
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
