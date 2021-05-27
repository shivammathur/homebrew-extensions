# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.38.0.tgz"
  sha256 "4bec8f981b7b074ed78bc42ef229dcfb6c5fe3782f29bc4980b4da00866d47f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3752996bb4e5fb12afdcc329c2b3b6c0d3067d097c5930e52d46de786221f98d"
    sha256 cellar: :any_skip_relocation, big_sur:       "8e50fbfe1a540b2eed955792ba7666e300d075dedcc9208d8961f36336611ac4"
    sha256 cellar: :any_skip_relocation, catalina:      "64bb2bc180583daa2d0427a34377a162ef8912cbf1be19be82ce3c54f8175be4"
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
