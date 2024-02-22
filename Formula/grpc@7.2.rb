# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4c3a7658d9b5e76e1fa2d4f8a55fe3ab3e3314bd14626e745f55486ae7e89c12"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c9763a7d4bbbd65720b849497195b3f2c0c045265db689fac6ab044aa95ee3c4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7a4a1538818131709114977e8c651f1456839a598c5d466f5114dddc7ea93eeb"
    sha256 cellar: :any_skip_relocation, ventura:        "3369a4ea967b29b1f12640ac8349e72d6cac5ee7fe449734fe6500002cf7644a"
    sha256 cellar: :any_skip_relocation, monterey:       "be3879f4c639b2698f902b01e34bdcbf1b43b93ae068a4bcb3e1f3f58bc70f1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9ba44dbda5e8c10d22c723337b52d71d20a046836b983fee14f4ed3f32ec4927"
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
