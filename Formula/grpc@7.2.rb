# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2195242b8e1e228b70d93a746b8452edf52aa4e1453150961ab6962613f8624e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "be3b201e3aa9e664b1fb9bad677a5e2f2edc263aea42da6bc4defbbbc67d1962"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dda57bd41d4df029701c208f1d4c5ac4aa06202e4c3fe5dd9989e1df0273908f"
    sha256 cellar: :any_skip_relocation, sonoma:        "e8a3d36f5ac405d1af1eca5062d3d866ed75ee2a0b605ab0df2f4426a7a69d42"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5b03ca6cff20a91400b7aa13288c4d1adc5fd50e4abe220eb6b28ce701705bb1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1cc16ebf9fc967d7233cc380f7beaa9d813b5bb527fab465721da9b6d2dcbb28"
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
