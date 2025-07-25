# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.74.0.tgz"
  sha256 "972ce8a989f2c15a951444950c1febe84eb88e59aeaca29d96e005fe55df1fc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d305683cea5d13903d4e95d372c3be8a65dca9baad9d1c5806aa9144e31f03ec"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2004971620bd87f344f7d701b95908c67d5037f79d0e590a56b15af375573de7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3520d280e8628c7d1577ba889fc6cd364383d0213de7e54011613646b4deb3d8"
    sha256 cellar: :any_skip_relocation, ventura:       "4de90d2cd4e3c69d4cc26ab1589bac08e6ef4922f60a1f53942756fd35810e41"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bb5abf6d1baced1e50619ce3f7683110d2baa57c5a6c2c85d71ab0686acac615"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a991421a4e1383c521ef047f4fe68255d0f19439b9037b06f61ed3744d8a62f0"
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
