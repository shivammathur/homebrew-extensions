# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "222cba9f92b290dfe7802c78d2caa11bf1c865c923d369f12ff87b11187ffae8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d2f544a0050289c71106ac1da17c98216e00f6a6c9b95d3be529ad9e9e481afb"
    sha256 cellar: :any_skip_relocation, monterey:       "c2ef11e9142073eaa41935fe500b715267c6d92bd9f3fd286d74e009d7336ad8"
    sha256 cellar: :any_skip_relocation, big_sur:        "008709d92887fa087fc990c73074af58d5551364a09031bfa35f6de8f961d1d0"
    sha256 cellar: :any_skip_relocation, catalina:       "bf8d3423a3055f18c40823e9e977a890fbd751c136bbd09cef12a5818f2d582a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4129f6ac20eb9ccbfa1de9d74b0e913eefae9bd6d2f4eb7e32ce7bc6f80e68d"
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
