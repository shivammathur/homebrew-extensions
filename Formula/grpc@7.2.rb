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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ad8654e1a7f538f0a96e196cc8ae365e8b2ccab25049511a5a62a322b694e83c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "21817e233ef77ef8973c301e53de39e111bcba0d5f016a9681b6015b7dafefb7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "211963e08062e2d06afe4a28e23c4a611183ef36c4d9400251649e9b61cc6039"
    sha256 cellar: :any_skip_relocation, ventura:        "1e9c113ac8c1f399fead43a34be9198f2895c3a9b9173d9fd5ac86e7ef99c2c6"
    sha256 cellar: :any_skip_relocation, monterey:       "26a2d66aedb3f70ab5d5b9d9aba0db02318def80d3db5bebef4b55743628ddb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eeb6235e1d512c6d3ecb5a6f7388354d4147a84fbb2930a6442f741a73228832"
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
