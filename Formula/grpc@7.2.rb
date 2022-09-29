# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.49.0.tgz"
  sha256 "dfcd402553a53aac4894b65c77e452c55c93d2c785114b23c152d0c624edf2ec"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e47cd4c078f3ef0898d42d12182f3daf4fe130bb87437f8ad0de26dd20e97d31"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b41d2024e09a7044c00a90d5d6353ce3ab064431a9cc0ed81e8eecbe729fa012"
    sha256 cellar: :any_skip_relocation, monterey:       "47fcc16eb7717b7944734ecf7774232b0ae7e0af7502e1af5da72673cf12a621"
    sha256 cellar: :any_skip_relocation, big_sur:        "ed0edca4e9a24f5dd4a3dc9e8bf41fc7127d3f77f61b14e6a04be59a2bef1e8a"
    sha256 cellar: :any_skip_relocation, catalina:       "26475c5dba5957f720ed4d350541cd68ae3298828647ca9dccb4bf75f109d114"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ef4a29b5d5e777571bbdcb2cc070043a4cee54707bd1fc2e32ef9808d63f8118"
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
