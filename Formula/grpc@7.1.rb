# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.41.0.tgz"
  sha256 "62d7320d7e26db29254bbc5770b70ba1f902952b9c6f89d34461019e7f8086a2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "915b35c384049c8632d3921cb5ef177ccd3561c35a48ee4aedba0a5d014d3f5e"
    sha256 cellar: :any_skip_relocation, big_sur:       "28af5faeb60586e1d8bcc99a98af8e16a01d7c056078e0366d3331e96badf80c"
    sha256 cellar: :any_skip_relocation, catalina:      "82ad0687e9982fd22a0f65537b5efd04775706e5b8afd09bc675f622fec522a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b40b9b95325d9eb70bf216ebb161275d3fe8de695f99a3b8130bfb836e3adac"
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
