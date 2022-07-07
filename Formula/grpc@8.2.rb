# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e562027e3d6f2b10c2e9b50cba2a98b64fec89155bb135e38541af19b5af5281"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "85ff40093a22d6cc6d0fe5b30a2c2b411818ffcb0f53b04f290770fc4142214e"
    sha256 cellar: :any_skip_relocation, monterey:       "279c2813bc83346c3749bdfd06614bdb48b27726525396545caad8b2aa21bc25"
    sha256 cellar: :any_skip_relocation, big_sur:        "6eb530b3440b2e115af104f4f12911be1e6f6fa5104d9a0406df1878c5ca6963"
    sha256 cellar: :any_skip_relocation, catalina:       "c95752df275b044400af83d9cc8c0bb7dc81a3a666fdcdcbf57999024e6e3958"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6e179b5598c968757b1856864c112c26642601a5eb4d62946e76270a6764da2"
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
