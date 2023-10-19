# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "668b7800561b18f00c36849279c2d20e843bd52ca047a854a0ffdeab74dc4e14"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5930a60d60237a270e177b1f4b6e7db49ccaaa1454fe65535d8866a5773c3ecd"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6093505f3e0e54fa380d19e706e88d8026715cedbb57371b7515613300ae8344"
    sha256 cellar: :any_skip_relocation, ventura:        "d17099e20c9df721b9d7e16333f338f2320c66a401a586791d2ce234a9822a26"
    sha256 cellar: :any_skip_relocation, monterey:       "0dcd2e8e628ce7187db8da04d18720d2d4d17f019ffab668b0669c96c7ba2ce0"
    sha256 cellar: :any_skip_relocation, big_sur:        "587be7659a68a3df0b294129c54217d88bd0976a3abd2a9c4170f8c5b816f2e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d5ead4f38f0e3cd7c358ee01ac2d22b1c76da4d21410ed2f833c70f8d37f6568"
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
