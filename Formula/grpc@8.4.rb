# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e17d268956c216a0702e90d97babba8c20d879ec5af6ecd8248ed2afad8694a0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "27f906f20c47f85a2c42b491fdcf01c125f78fec43b3e475924d45200e550bb3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f512b236f4df910bf6ecdadac28a527602a5f3890512b7a714fae8a6f97a6035"
    sha256 cellar: :any_skip_relocation, ventura:       "d9cccd60330fcbf4cdc6fb7f861336914773ec8155bacc6c16011f80301d30c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47a7c33dc855b39b6f5e8dfb26065f591f947fe966cd9357713d34e12b68fd18"
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
