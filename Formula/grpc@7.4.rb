# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.45.0.tgz"
  sha256 "48f9c408167cd2c5df5d889526319f3ac4b16410599dab0ef693eef50e649488"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "431e69699c5f030af26b545ee7e9b02694469cee6c862a606671999dcb321981"
    sha256 cellar: :any_skip_relocation, big_sur:       "a760ee4a85ad92f5cc33babb6333d33716690eca5e20ffab62c8725814b2d7ec"
    sha256 cellar: :any_skip_relocation, catalina:      "1dc8aeb129be4f5e266c0c4b19ee7eda837d5a3452542b3062ce0f2db01f4673"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4865a6f2b38b61f7f32adf0a369aeb52bce9d07f35bc7f7bd226f530b5e46e4b"
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
