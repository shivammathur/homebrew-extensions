# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "60dad729fb9d0ecd008cf79a108b979132e3a1fa0cfbf86caebffcc5f242ad05"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e16535b456e248ea2422a95a5199d9c03585736dd0b9b151d42cb529ffd6c818"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3c3748e5b4149505d8b3aff0184648816e1613444d13839eadc1a662e77b24c6"
    sha256 cellar: :any_skip_relocation, ventura:       "c039c7ecd5ed465a155ffa504b8fb0aa53a661d211de9109a49ba6340e24fb35"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "adf427aa5c2079c644776e7b6214876d82f78ebadb42a4d32827cb934502cb29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31533790f178af74dbbc2a7f1bcbe992d5c8af964c210fcb43d0af456099e6b4"
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
