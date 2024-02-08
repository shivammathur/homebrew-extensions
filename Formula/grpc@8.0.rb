# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7a539b2b0ff4b5c3d8e61fb27c3f5d112dccc5744240fae67acb28311e368c90"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ebea2fea25fea1d5632cf473ae235eed2446f8dd740776cdf5427e529330b0c0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "aa8237e932af2258098c54a13807f36ad86929bba53b41c4ca4c4da3146cfd35"
    sha256 cellar: :any_skip_relocation, ventura:        "23b519128e1a7e137fd8e496e2ce6d9904f46ff23d0021bb669e292e87aa9540"
    sha256 cellar: :any_skip_relocation, monterey:       "eaefc54f02ddb6f0ade44265065f3e2c9af33849195bf67410395ad141912b6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "51bc3c68b78fab8239bddca60eec1d3b9e4b7fc04f7f5ecde36e12d797caa6e7"
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
