# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.82.0.tgz"
  sha256 "bbcb83e229b565feac351bd88bd80091c4ef613357122fccf8a9930cd988d6ca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "be7f03f0caa101d3a680a459e2b2e051f78604da7b3124ae14f78bcee0a9260c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "48bf9b500549b66058ab5ee3e3f27d66e29d79fc24e7ad3d173b6d9ac40ae6e8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3adebadaab6eee11ab05744b5da1825c76aa07c68d7c853ec4ca3679908c4bd5"
    sha256 cellar: :any_skip_relocation, sonoma:        "e7162b889dae033e13f6fbd8786fecd8655aa9da7e185a31ab04c7445cab3dfe"
    sha256 cellar: :any,                 arm64_linux:   "2f1d63dfa3ee1b27e50ab93b8e339ec1945af6e4de6e93e46d3418f6ef86d49b"
    sha256 cellar: :any,                 x86_64_linux:  "7b02522f72cbf856bd7d3186749baaf014d5c7dc619de016b6f377863e5825ff"
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
