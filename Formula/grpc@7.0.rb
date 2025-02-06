# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "11c02f17cf189f824faeb19fb7678c8fc86fd1de49b702416784df64f1a0f18c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3156e7075e0d738a2e27c0c3accaa58b4ef99ce292b4e101dbc64b09fe47cf26"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "09c12cafae431c2aa43a9e26363f994fc03017f25a08e0b9604ffeb2c77ecb05"
    sha256 cellar: :any_skip_relocation, ventura:       "4ae1fc48280a7a477a7df96b681f3beaef4db980d1357a36792cf3e433ca5bfc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ec2c2fa2bf1e1ad7bc8b546b21d22b982c443b46274ddb48e0f95ea437fdc3c"
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
