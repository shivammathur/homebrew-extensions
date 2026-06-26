# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "214c4279c0dd0a851e088f7b631594c6c3b91564567cd6dc17fda759e200dda3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b6db412102254bceddb41b6702d7d1eaa4807e7b064bb8173e9aae54a8e61af3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c7c57f6124a32d34867aceb4377ac900840af683c95b91628682c064bac60cf8"
    sha256 cellar: :any_skip_relocation, sonoma:        "df0f8a812ae8374777686ede87bba6c7439a9a59649bc09ae42be3d47cf2fd7b"
    sha256 cellar: :any,                 arm64_linux:   "10485b31057c37cc1ae769a490263d3e41a0ca19ec17e0e6bddb8f523e36db15"
    sha256 cellar: :any,                 x86_64_linux:  "c2dc2a117129e4f1aa71c37adef54956442693872ea57ed24ed93ae3f2403a91"
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
