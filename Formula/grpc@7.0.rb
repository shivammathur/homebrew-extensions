# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.1.tgz"
  sha256 "2abefeea06491ac76862bacf16e78732ffbf4ffb0b0e4f74263d4f1a5c7745d6"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "32c4198b2300a13dc0e683e29502096f1bfccd89540c547863787411554dc909"
    sha256 cellar: :any_skip_relocation, big_sur:       "66b34f38f0e203fb93a1024837e88690a8a5d7c0c2d016d493cf0bdce0169896"
    sha256 cellar: :any_skip_relocation, catalina:      "d97b11524328cae6efb82fc27ea0d81798621c41b2ea147e994ef4dbcf9787ee"
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
