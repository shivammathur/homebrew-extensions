# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "141201123213809fe585bc77e611bd74de72e8f6ca8e7cb3195b88e827679b92"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "76b25dc6c126fda8f9817782390fde2578536d85e5f6428ce5f5ad8f93cf9561"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4cf02676f63905b865d44c72f4708aee90d84301abccab964f62215e5ebaea12"
    sha256 cellar: :any_skip_relocation, ventura:       "731035b578074c8d3eb382dd27d2078c7ff2f10e264a442535a839fafebfddeb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "88b553e42c3809734c9d707f5c62b59f0130883a07e22fc476d5dcf59ae582a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11afa4cd98f9cfb7b16fbbee25861a49b0e87377a8cb1823c4cffa2e270aeb6f"
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
