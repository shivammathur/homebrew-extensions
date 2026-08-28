# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.1.tgz"
  sha256 "cb06519b1382f57ba6f5358504cb37e933d5a5892553300877fd4f3b04cf0560"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c9110a892521f2b7a7d8ed6c7dd4a008c1b9b4210c06b89babb444e08878f36f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "81d77751ccd58a5ed59ea86d85a6afd08eda31738604876719f5ee690e9b0de7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "534b8c23e1e74ce98ae6d11dffefe0fe9a2cbdc757a66b4868f865277cff7f17"
    sha256 cellar: :any,                 arm64_linux:   "4317f953d022c8b20e65fe2c819a3e2c94e7dbefc9419aefb044c6f520db5454"
    sha256 cellar: :any,                 x86_64_linux:  "49deb0fb6dc6858d1afab675e463d7c7a603c6dbcae80cd4a9b50476d84d1e39"
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
