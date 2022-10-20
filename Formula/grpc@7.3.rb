# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "17c50e11268f03518bf8cc73d0693f511133b18f21e584ec628e6ae47618cfdd"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "fda76aac0111c65cf1dbfadd390c1a5d6917e963497092a48863dbd19c8f9e03"
    sha256 cellar: :any_skip_relocation, monterey:       "539534d0524f5a9cfe4273b24eeb11edb43ab1ee39ca42ef0335dc3243b26efd"
    sha256 cellar: :any_skip_relocation, big_sur:        "c65226a24573451778b4415c809f1a98b911b3b64142be690c39f16f4522405a"
    sha256 cellar: :any_skip_relocation, catalina:       "d6a087361d261a6c42b2394618fcde9f2ca71ebff42de86f129b00c790944c48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d67aa6e1339adda0681d7b1e4d1b8f426a94161696c2cdec4907833619439c86"
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
