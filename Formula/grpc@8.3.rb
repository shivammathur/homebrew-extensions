# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.73.0.tgz"
  sha256 "63959dc527c60cdb056842c5e5ebb45b507452bb121653604ed94c1c23972c7d"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0126e3e39f2d34381dfddf8bc1e2ed16517468354f9a57dccfce5f0505b824d1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5dbfa97e2c749101160fae432eaffc586878367ec6b3842d3f96e286cdc509ce"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "56f5d245316f5025eb8007397389e509e2956fc53466959b48535805e4933e76"
    sha256 cellar: :any_skip_relocation, ventura:       "95c2dc2ef5553c438515375c78fc2cfa9a20c252182c16f21c57ba0deeb0e4fe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ed56000f7d2abb929eda8067446ffde3bc6644d27de7d18641fa5a0d90fc9b54"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f716f3d4143f9bc956b2c1d8d6c10e1f3d3126053ba94a35416806f0129c2ae9"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
