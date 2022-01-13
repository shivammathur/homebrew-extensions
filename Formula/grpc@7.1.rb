# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8e1841fc1788d01cc6f1bf09ce1d60ff8df6d1d297e141a2fb0a6a8e591d68f3"
    sha256 cellar: :any_skip_relocation, big_sur:       "57ec6b37e613becd404b2badcc9d067f4061fbd58f2c9600a051da5a28414a06"
    sha256 cellar: :any_skip_relocation, catalina:      "bd8624dd02173dbf1e6e4c29adc90451222467bf1af362f55faef945dbd50a16"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efd2e5172e279dab32a5cf3334abacffa2566a33c0a6f4c71b5eb5079b055cbe"
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
