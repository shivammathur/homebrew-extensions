# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.0.tgz"
  sha256 "adaf30db949767bf0ff5a5308638e4b9bb5f711733204ed5a5e8f3014d80a174"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "42271edcaca3a4edf31354ae356498a399d93b91095a2c0c20a1ba3b7aab56c8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f4c75406b5cc25b95a3d8ebf42549731f505b1e3fba29601dabff5fff66813b0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "cd6318c3896622b7771e9691e3ddd94aa208094046846f5c720688e28b589c77"
    sha256 cellar: :any,                 arm64_linux:       "876ee28d9fa5ac62bd856c83c0aa21b5a51480b63075a2a4214851523fd13708"
    sha256 cellar: :any,                 x86_64_linux:      "f8a0602d8b6a17bbd1310b2d4fb464fbab8e3dfe50fdfb886da8d73f90072fa8"
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
