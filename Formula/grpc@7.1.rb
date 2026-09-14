# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.84.0.tgz"
  sha256 "555716233a5cc9a6baa605719f87b7688a88fb8bfdd9b4493396276244d56625"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "ff9227643d9ac2b349f0fa741f299d3f52628a98d2a72f5559a1cac1614ce7b2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5b3f15f8fbefd8a45b5a314f7e1178bae4f50b655e0b2e8a77a748caf8ee85b6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "f374d0be4ade7eb9c5553c11efba3e7d67bfe931391acfbbd0d45c0b84ca6cd0"
    sha256 cellar: :any,                 arm64_linux:       "521fba051b416326ef303f4ec081e503a0ce4e95c12f128c6e22ea1297dc82e4"
    sha256 cellar: :any,                 x86_64_linux:      "6f01b5f73b279a4c3e2181bed4be0a69ef1a7396c6182437c141c06df4c7d842"
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
