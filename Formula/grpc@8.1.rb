# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.46.3.tgz"
  sha256 "2aad61230afda3192eedad25be918bda628e6aa18bf1ed7e3bcf1944e6e4f4d5"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "86d6b32b44c39212f982ce4d675acfa6c7b09fbb4bcf512b44529bf738fc9090"
    sha256 cellar: :any_skip_relocation, big_sur:       "71c3c98be6cc708bf2d52d26a307a3e49827aa8a5858ee5d5fa6f010d453cbe5"
    sha256 cellar: :any_skip_relocation, catalina:      "afc106bb049ae83c0b5d8f5e7907fdba3a46de2fb97c6715566952727d733d84"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37ec2810587c5523d095560f769f04f1cac0dd5c6ee3f201354e90384d0e29df"
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
