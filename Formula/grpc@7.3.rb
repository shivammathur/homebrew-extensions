# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7712e41fdfb08f428e1275c4442abb9903d1a0fd2e4e79e060afdc5e02a357e0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c624390c737342639e1bc18645189137e27d3bb31f832777dd731de827b43091"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f6785974180020ba42be4cd37d0c9f0908fed479dc2ecbeea05f72fa4d57bc00"
    sha256 cellar: :any_skip_relocation, ventura:        "d61907690c677d99b37eb752bec2ec2265b784358866b54e866f244375a1c1b6"
    sha256 cellar: :any_skip_relocation, monterey:       "22d818ac0308f68502610fb70cc5d6fc1f1930609ddd98f5fd6c78732d4df2a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d4d0eba2ddeb696536d7b51229becdd5948e2a2f816517ed84a9bb82c75aa17e"
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
