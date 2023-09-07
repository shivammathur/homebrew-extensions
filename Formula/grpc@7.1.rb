# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "13c4c6232a1a5d3ac53020996ceed2e99cf8585bee191b50b62d72c626c01e99"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8dbe88b38f51bcc98438846b7a49c37e27275164cb835642ec5273ae89a1799c"
    sha256 cellar: :any_skip_relocation, ventura:        "c59ca1f8daca63a51804a6713fe908f1e5be58332266c714d68a9b249a5e2cb4"
    sha256 cellar: :any_skip_relocation, monterey:       "fca43c0376d058169eb95b291e80914b94304cea2a5d32bc3c6e8ec0dea1634b"
    sha256 cellar: :any_skip_relocation, big_sur:        "c5e261349f45804959e769dd3bfd7722f5f48bc1ae32bfa533b816f17f4199dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3ade39975cabd7e1c310c28d493b22906cac19520b74ecb4fb4811aa4bfff762"
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
