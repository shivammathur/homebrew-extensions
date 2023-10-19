# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "37109e876c9c2f619bf7d241d53e738127f010836aab7d89e722d8be94ea284f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f582016af01347369ac5925fcd3801e4749d2b1568450c02409b16655725100d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "914b09a47b97b9a8d7e5da0e11e4190489ddfffac1113c59afa49e2b86d2eea4"
    sha256 cellar: :any_skip_relocation, ventura:        "4d63c698907b23425972dacdf5bb7dc4fed932e752af374ca6ecaf78f18dc5dc"
    sha256 cellar: :any_skip_relocation, monterey:       "b90054e393cf4da4e0808cc50ffe99c9be9defe58e960fa3eab2719fc720f091"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "11dd2b98a67ff23a523024b1312b48a357729fba6bfc2ea8fe9821b07b28a740"
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
