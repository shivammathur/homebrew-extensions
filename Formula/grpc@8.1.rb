# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhp81Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.36.0.tgz"
  sha256 "819becd24872b95c52ad1f022ca71f6f5eed207605b19a26e479b1d5a62c8561"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "093cfc74d0bd244c154766f9f288aebf19aa7baf05221ae03c867e3f3d477b8f"
    sha256 cellar: :any_skip_relocation, big_sur:       "c2aa3b49abac58b23c262fa6709e44f96fda93a04f9a2420f7a4dae4938b4f94"
    sha256 cellar: :any_skip_relocation, catalina:      "e62d5ec09afb50948dbe0a8d740945132c06862eeef8befd19073368bc6f03c8"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
