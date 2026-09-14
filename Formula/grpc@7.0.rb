# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7c74e8b79c1bbe9b6a03fed037d0a507885447da7cce6b644c406be025ed2e5b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "a09f2e594e71e865104e8ce559068b47c7c22f4c09b91fa2ca1ef3197a88a303"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "4c0aba5029fea93f6e62f3c0d1d2b5d9b283f29f2c7d431e3091bcfb171bc7f4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "e82e63495b7771f4bc3a94f2ee7737b40532dcd0b892be06f77e6dd9aec2635c"
    sha256 cellar: :any,                 arm64_linux:       "c1bcac8700328f84d87c43925c9e7d64aa8c5a32c1230d19d72aa32cee28b004"
    sha256 cellar: :any,                 x86_64_linux:      "bb97e8b8c1210a0fe294023a885d5b3149997a9e213d5af30555e9b4ca5642e3"
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
