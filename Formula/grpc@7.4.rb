# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.52.1.tgz"
  sha256 "f8ce3ec8ab3678c70d57fe60982dcb6562a6cc162718cfbe74783915b49803c4"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d6b1ac169a4de211ebec8bc5e81cd7471e197439cc81fd21cd37215f906cdcab"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "67426f7ffb78e27e175944a5202b3369dae0e877ac901c95d3c1ed210aa694e5"
    sha256 cellar: :any_skip_relocation, monterey:       "58645d8782131084e664581dd87e1e717f9ef5e96218265fbde8a84702fd8c5b"
    sha256 cellar: :any_skip_relocation, big_sur:        "b6970ea11e53ea2a66b7bc1fbcf1cdfffc759c02a1dfb7146c57d736e5f1dc35"
    sha256 cellar: :any_skip_relocation, catalina:       "df4539be52e7eaca72218ccb0ff89c6172dd845f39ccdaee362b452e63086630"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "413482044374a563832510b2141ba642f6b15f24ccb0a3a992502018de457ad6"
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
