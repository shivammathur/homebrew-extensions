# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.1.tgz"
  sha256 "2abefeea06491ac76862bacf16e78732ffbf4ffb0b0e4f74263d4f1a5c7745d6"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "104032ea374b2d975c0e018c2469907e9f4eef006020ceb0f5fb24f87c63e55a"
    sha256 cellar: :any_skip_relocation, big_sur:       "73ed295bb7bdde9120d0ca8f4a00ccfbd157571c24205a7c3d252fbfb93e5b70"
    sha256 cellar: :any_skip_relocation, catalina:      "b21dd7d67115138abfae23e3d03e560a56e1ed5dd3f8a3259e245a326993e1e9"
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
