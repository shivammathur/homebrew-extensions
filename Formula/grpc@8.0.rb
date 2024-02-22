# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "504bdf5a5c82b87a5ae6d3f23a830c221cf76dabb62a1b7f547bcbc99aa791b8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cd1128d812cdbd29f815a91339ada041125fb1d9d033966a633c748b640bbc7d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "db77c11cfa09f445b0766a35080f63dcd6b80429c3082b204d3ad05f4ada5858"
    sha256 cellar: :any_skip_relocation, ventura:        "76118b4cca7c922212a8888fe10cfb763251471518c226e86a62091f29a9eece"
    sha256 cellar: :any_skip_relocation, monterey:       "d9a2431a73b9e93e97ee9a6e20299af321c10759e2aca96eccc84383a23c5efd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d3ba14c0fd30025ae0175fc6e5afb3cc4b1cf07a9fcde82d15c06246a83af106"
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
