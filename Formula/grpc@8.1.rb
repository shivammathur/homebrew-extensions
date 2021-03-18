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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fb35f063ab54c317b4c138477aa719659815b6f55af84515a126f31f16a186cb"
    sha256 cellar: :any_skip_relocation, big_sur:       "b710c87b5d0c6dd5cda1ab5596325e68877fa0e3dba9af0c1d0c2c26403eb6eb"
    sha256 cellar: :any_skip_relocation, catalina:      "c6c678c06bc75b2ba94d2524d11634db997f67f3f41c2e70b5b57d583416e319"
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
