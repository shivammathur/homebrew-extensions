# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.64.1.tgz"
  sha256 "7eedbce54e29281d8fb97b0924e34d6cb315c5ba12e8a55706ccdde977497d43"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5a899b56f202fc067f0ab8974993a4d7994684dd37cb92a9dafbcf39826e31f4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "78b36294e18656067aadf73ceb86b86b13a16a1589a642fadb4aa4d413ab920a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7bf96c853cb1c2c0ee91d21d932f38f831290e7d2eedc496c7ca2565f2714b75"
    sha256 cellar: :any_skip_relocation, ventura:        "1d6174b9ba429ef9b437e1efdb8bd6d4cdddf6437c8d616ace4f6c6cf65bcbbe"
    sha256 cellar: :any_skip_relocation, monterey:       "29937baff32eac61d9903c0e45b1ebb6c388758de69b6c5f0f303a9e444471af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "173b950bc6eeec6a3ab4ccc38fdbcd3f3fd1587a66f7ae54dab91e243158f8b8"
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
