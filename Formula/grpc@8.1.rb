# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.64.1.tgz"
  sha256 "7eedbce54e29281d8fb97b0924e34d6cb315c5ba12e8a55706ccdde977497d43"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ed757fb3c65172aa285a7e2b554bc1273cb9473ae6fc5d9df6af10eac3d61e8e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "91f8658c5c0cd02dcbd040f3a9ba415c088f998eeb9fb324a6244e9ae52988dc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a52e31df561c6bd07a929d63336ff429de29b0953f6bde2115d83f4796059aa1"
    sha256 cellar: :any_skip_relocation, ventura:        "81f7713dbb8ab2b01bf463e27418e930c74b45c4fe7c5276066007b3461659e7"
    sha256 cellar: :any_skip_relocation, monterey:       "24be8dcbbd5e51b500f41fda9f8027eaae41f42dd76fdb236225797f8fb00e5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aec14d8d633471afa77575cd48b6739fedcba953f0f3f5865a46f0f6f5fbcf9e"
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
