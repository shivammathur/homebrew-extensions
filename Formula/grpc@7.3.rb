# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9ddac94b9a02a790e6ba356ec08c4514e4d331a0283aa29a1fc10e93aa1b7c78"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ebdc3aeb8d29d7ea08242d865d2bbc2299d9d461f1213161fbae64e36e695cc1"
    sha256 cellar: :any_skip_relocation, monterey:       "7eb3b85cf0c941ea8a91eff7d3ba47930253993a43cd7c2e40897bc734aba431"
    sha256 cellar: :any_skip_relocation, big_sur:        "7213fa4e3abac7b895efd3335559140bc58babdda8fc3fe8f237cbcad9ea2b0b"
    sha256 cellar: :any_skip_relocation, catalina:       "fe9ab2c3b0e09995bfbd5c0bdb91c7e5613378afdb89ad5d69724a858a177f95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ccbded916d82f69c6a47b32d536b50aa1f29d9827d4c98f305987679b4d69fd"
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
