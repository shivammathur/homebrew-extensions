# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "feec12de38f03f49fd11ab4e70e495cd609915fb055893461228a00a1a7ad9ad"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "864c096e8aafed223c7e339e3f191259c7b3f710f88eaffc2847dda86326311c"
    sha256 cellar: :any_skip_relocation, monterey:       "f3c8e0a77027e08b4af18ff1bbfc381e1edb743949472f865c5842b94c677a66"
    sha256 cellar: :any_skip_relocation, big_sur:        "1e61886055f53303d1ce5a44d44e0a05684d41cff36c499a366582afa0e4547d"
    sha256 cellar: :any_skip_relocation, catalina:       "5a9517539bcc558c88b74fe1c8843150a0f152faad635d8156d73b0803d185a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "017888cb57e492f26a02680cb5d09b1c7f07364e1d1e3a82f6bdab9cfa361624"
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
