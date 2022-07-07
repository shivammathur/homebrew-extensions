# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f34e3612ebaa482e4bec5efd93717416f416f94360d5bbba0b6e19be4418985b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9687ea27ae0839b68b7225ad8cbac74f0cc547cc1384cc5281f24a1c214df412"
    sha256 cellar: :any_skip_relocation, monterey:       "98ce80c2c943ac945298322bc3e2f37221157d3df9d58a570643231d75261f0b"
    sha256 cellar: :any_skip_relocation, big_sur:        "af7df3896bc15fed719037ce270da390204ec14d1b4a9234a43354e718ba652f"
    sha256 cellar: :any_skip_relocation, catalina:       "20634187819ba7702afdb4a46c2bb906e85c6c756780308f0ea168c73ae9bd6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "72cfe6def4a7abf7e125b11339926ded18594dbae6e0ed82936a333243dbcb47"
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
