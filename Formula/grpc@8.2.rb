# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.64.1.tgz"
  sha256 "7eedbce54e29281d8fb97b0924e34d6cb315c5ba12e8a55706ccdde977497d43"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "717798781410668dfe74ebcf40ef3b224c78ef21410fcbf19faa1a8c27110c6a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f4fdf1c01ac9a60606b90a451c0107f6088684178baa1b32f9ed803ffa25ba2a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8934e7d89ca6f20cc87d739ff5c64d233840946e54e3b03fd892d2ac64ede0b1"
    sha256 cellar: :any_skip_relocation, ventura:        "7dc061d220433d93ecc655ebf2f754c05f20e7080c16fbf1293fe5763d46db07"
    sha256 cellar: :any_skip_relocation, monterey:       "a9423e75ee6298794a7d2aa80e0d6a39836334709e590f0b4cabc10fc0f9f012"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "227105699b1a220ef4eed6fed7593434355a1c465c68871d7f94c563f69fdf66"
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
