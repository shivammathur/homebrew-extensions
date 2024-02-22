# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b717d55e8526eaf106488032c117375e5315db39059aea866c14ec280c607ac5"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3ea1f89104dbd4f7f13cf907c29cdb065caa399fa2dc0d6d4ae4ed5b17d47fd2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "46e9298ffd2abbd91975166f51defa4f5dcd8e7987782dadd68dc74bfd785fe2"
    sha256 cellar: :any_skip_relocation, ventura:        "49b180d68ccbc471f670968365a2153d530c0ba2eb689ac3a5a0a2d4fff6bbeb"
    sha256 cellar: :any_skip_relocation, monterey:       "88e91eee58e4212661bf88823254274fc8c06e9e66abe3f4fcebf5e5252baf5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1bc3d3a7b7ef427f313ce5379de21c18230637ddb0f11d90f143b711e8bfabf1"
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
