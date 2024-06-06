# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.64.1.tgz"
  sha256 "7eedbce54e29281d8fb97b0924e34d6cb315c5ba12e8a55706ccdde977497d43"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "457654cb32365a81e152d0ef0ec1138eccffb7b0c2f867728332f36cf84de689"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ff398b9da4eaab954ee0f6f319e41a053ac3ac87c9bd0f790736fe3cea4d3728"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "999929ed447f7d1c1eb442f44e11bc100b3c5314b1cda8b944498eb25a6452dd"
    sha256 cellar: :any_skip_relocation, ventura:        "8c125e02a9a8ea78aee9097e9ba4aea25e02c491ba72fd8ac0d4c3c1c90b8372"
    sha256 cellar: :any_skip_relocation, monterey:       "5440d961a730ddc68714e3182cf913764cb2a32d0405141b216c1df5107bac84"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca7c12580ac7eacc932acef6bd3e8bddef90f99b2bb3aed73d331a4cde2c8118"
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
