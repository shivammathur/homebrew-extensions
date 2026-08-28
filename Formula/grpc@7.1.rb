# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3d7b3e3bfac2acea83ed8ea907528ba1a9e406b92e6d3fe0db5473116e09f406"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ee39d3ea32114cf8f2e1c4a9fda56d38cb73f2c9e8e807b77fc0d972b742fd37"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2814879aa76f57c7cbf070344b96179321223e76cae42e7b1654601eb443dc51"
    sha256 cellar: :any,                 arm64_linux:   "a86406dc4160e904c829128721523326db211c65de64514ec3e1f12a46f3a0c1"
    sha256 cellar: :any,                 x86_64_linux:  "7757bd19148e6739feec379c8384c3ed911715da7a071208a363d040edb991f4"
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
