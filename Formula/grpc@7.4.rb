# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.38.0.tgz"
  sha256 "4bec8f981b7b074ed78bc42ef229dcfb6c5fe3782f29bc4980b4da00866d47f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "113f395bc03d6da247fe7768422c80a4fdd1248d95cd3ac4aeeb1521014d3fdf"
    sha256 cellar: :any_skip_relocation, big_sur:       "9a9a73e09d62a22254016d7531bf8739dad337fb1b08641678cd326895e11d72"
    sha256 cellar: :any_skip_relocation, catalina:      "4e2553fc31bae8953ad362ee9e674db8b69ccd06b4cebbcf236401d38e569396"
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
