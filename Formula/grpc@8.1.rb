# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.39.0.tgz"
  sha256 "912bd2d2bd9d5b6e2ed861a79316a14811aac6f8e1a93c82dfc993430639d004"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "064c4a250947ca0cfdc537b197827661b6fb81f097c3bbc60a9845ff2264a133"
    sha256 cellar: :any_skip_relocation, big_sur:       "8b6a1e3bffe420679fa64df188b1817ba36256be23c885368e76ac97849f4b62"
    sha256 cellar: :any_skip_relocation, catalina:      "a23673a8afdedccd9de82ef2de7c35a9873a8d85798029b48848ee6ccb2db3d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "883cbd8a2c4802cfb5dd92ba54959bb70029a079b702dc781f481e485bb9fa3f"
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
