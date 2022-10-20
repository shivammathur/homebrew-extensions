# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0e7bb0ec366adc709229e8c5eb169bf57220e702ce119e82cea31893d2b512b0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2b0f408889ed742c8a7ec8a7077146793d29397f368799d308a7d8de6c6535a8"
    sha256 cellar: :any_skip_relocation, monterey:       "2852fe3b287183009faacdcda2cc9e7b40c9db7f8d788882a7156ba740cc1ef2"
    sha256 cellar: :any_skip_relocation, big_sur:        "d7bae94e56406d69b49ed0df663dc60942656ddebdef6a8367f3ca878b6383e4"
    sha256 cellar: :any_skip_relocation, catalina:       "5bcbd45fd1ae4c89898d26cfb391b171b7a871b339135d9ea0eda35bd657f34b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5a711293d2c081f8e469162f8cfbf4c96683c6974c0c9b991362b7c0e71cb15a"
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
