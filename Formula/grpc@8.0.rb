# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.45.0.tgz"
  sha256 "48f9c408167cd2c5df5d889526319f3ac4b16410599dab0ef693eef50e649488"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "84e02cd01fc9ea791b1b6510d84bc0f31cfc547a656f84611a507ef0f7e28bc1"
    sha256 cellar: :any_skip_relocation, big_sur:       "edbcc3d5d64a4bff1b5e9b82579be0b253f1f8dbd1350c752c1de04db8de81e3"
    sha256 cellar: :any_skip_relocation, catalina:      "e1dc7ba1a10e4e046377da7db5a1596eb27bd9d65aad1e2d3734cf419bc6cc78"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4fb40f82121a3ec998632ce116a9b68907a21a718030aab84d757fa11fa81f81"
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
