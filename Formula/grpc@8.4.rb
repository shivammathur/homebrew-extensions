# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "241e1d0b3d902763e1ebbea0c986af181edc977005783d03161ff6c3b2aac155"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "21271358e9d47a847dae4ab3f0a227589b8a487f711c3267110c7d2e0840f4ec"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a2c1d5d1eb9353ba458020cb3828954720e8b0287d253c7f652985729b1e0676"
    sha256 cellar: :any_skip_relocation, ventura:       "196b52270a17cd7520f6c1e9eeba7e0e2c7c58679a1bb4f4d5c22ea9f886343e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "09e83b43c7e9c130cd05e9febdccd7c994b9b46484809e603ebf94532261e22e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4608628f459aa11e418c098189d66e3aec938c2baf5f402227603ef2f5837e9e"
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
