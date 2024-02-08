# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "87665ffebdd0fe10251525c3bfe8e77c51d447f520f9e3e107f5290ecb79bb2c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ab147d5f9cb9bebbb39a4bd3ab96240308b03f1466e817bcb5cd732ff5ac0007"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a336d84878a5620afce45123132a1c57ccbca13aad88f049649cef9185bc6b47"
    sha256 cellar: :any_skip_relocation, ventura:        "4e647982eab704fd19f7fccf0c61f9ddbed95cb3758500a182e3c7bbf98fb4ff"
    sha256 cellar: :any_skip_relocation, monterey:       "b801ac43acebedfdf6bc734c8a64cda8a402f04ff754e758e3cdb66e28426b17"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca32ffc6b757c5a4bb62039ef23419cc84778ce7504213cab707b5ad59e49fe4"
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
