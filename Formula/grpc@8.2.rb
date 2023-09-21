# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b5642be67f03b77c27140560cc66d60d3de142e399baeb46f4f52d9038044b4a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "21c279f6278b36b6e10b4bc9c6fa3fce17db0550c12211a59914758e91e0c9f6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4571a4685949d76e28f325725de217203215f56cf760aeaf89efab8163e02616"
    sha256 cellar: :any_skip_relocation, ventura:        "e78006dc26c64b4d0418ac5c8ac5bdd5a521639156bdc975b627df6365ca9c5c"
    sha256 cellar: :any_skip_relocation, monterey:       "312b1e44dac1b95b6e8074e4dc8fec865f8ed0ed35c6461b6d0ecf8a61ed8e41"
    sha256 cellar: :any_skip_relocation, big_sur:        "2d822889bf254d960e48014b01cf3fa64ce7108ce75480925ec47f05bcc6870a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffdf366e88ecaec47be2d9d20daf262ad9cc529faefc8e2d67370c3d76ce7bb9"
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
