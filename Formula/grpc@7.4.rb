# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.73.0.tgz"
  sha256 "63959dc527c60cdb056842c5e5ebb45b507452bb121653604ed94c1c23972c7d"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e5a9c35d91b4e18a80f871f359852889cd5336f6dc8597cb9cf56e67a85d09d3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1c79e702c4cbfee0c09ddf1ecde5e001884b008c089c5701950d4b1a33227956"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d64935ae4deaa6bc20c522b6ce3f48ddbe0f1f481e60e76f7f7d98281b6dccb7"
    sha256 cellar: :any_skip_relocation, ventura:       "0b3d1db25bd51d3ccfc3e429314b081f36816e4e8a0fe7ba68b4011f94c1be40"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fac2166ae0c3596c129a7f3ba744fd1ec0b7303b07b4abbd809346ff76b72cf8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "718ec92c374fa44336b0edd34846ff787f5de921c1957a5e2ab7d82cd3725964"
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
