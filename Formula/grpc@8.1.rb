# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.54.0.tgz"
  sha256 "5ad3c1a046290f901771fc3f557db6c5bdd4208e157f42a0ab061cf10ac0dfa9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b058b7cb3a818a2ec569fcab63a31100f8edcb2ca59ace90f418a62bc971eea1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1435db2cdbc922d9d85ebdd44d195c68c1608b8cca5a22a40d2c7f3efc3ac720"
    sha256 cellar: :any_skip_relocation, ventura:        "cb2acec1f2ff071edb6e7f4892508240c3f941ca26ef4b4beb1459a4f2d5d50d"
    sha256 cellar: :any_skip_relocation, monterey:       "fc5eb63b14c9e0ddee0050be258ee655e8cd0375d428ce12cff006e2e629ed84"
    sha256 cellar: :any_skip_relocation, big_sur:        "c48056e12738c125b3f67f3c7e59be13a0a5cca9b7e14d87950a2772589e4d12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49dcc6cd3495bc70e428ab9622a80848e36b2f5ff7c21eb396e5b1f75dbfb238"
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
