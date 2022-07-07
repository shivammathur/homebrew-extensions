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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1bedf6ae7af22b1686349e51e1f68ccd0b0bba489a5a4f2c20d6753b5062efbd"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "fe756712fb445fe0efd107026c60f7beded4b3f09a82814b576e1aefcf4b5885"
    sha256 cellar: :any_skip_relocation, monterey:       "f7fe846fba276f661d6b48d16eb7e673656fbb79a24f9810d5fa09b11d7b2f4a"
    sha256 cellar: :any_skip_relocation, big_sur:        "eb6020c1bae9569dc509bb44c338b42ec75ddd9b318813bd2b17052714b85dea"
    sha256 cellar: :any_skip_relocation, catalina:       "9efcdcad8a4c60570d2490689098d45c452844c16f3d3737a804921364ae6e80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "43adf44ab33ccd7b06b9748b1203efe4ac245a455fe2d9dd0d65ef9e379f00b3"
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
