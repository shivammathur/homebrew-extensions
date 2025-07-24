# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "06618579ca2a91aee316bca7841164276d99e7fdc64b955ffc604fdf5c61892d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "730ab1a7492e5f82289c10bcedeedd8d42cf216819c2c8537a19c779b3257f90"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "518789dfc10e4fcc2fe352d7c9a160ad36cfa059e2fc99da4cc4e99b5d9bf3a6"
    sha256 cellar: :any_skip_relocation, ventura:       "43ba0e293c345057f8915e2c8729dc60f1f6bb0ca40f424e1510134f3c715c8c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "55452aa30641b38d478bbd72220f168ee613961ad3c78880d1ecef5be88f135a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9898d754aa027622a203783fd1f22f1d046cc8f4a3a51782473cd3ced3abc262"
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
