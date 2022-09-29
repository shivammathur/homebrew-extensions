# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.49.0.tgz"
  sha256 "dfcd402553a53aac4894b65c77e452c55c93d2c785114b23c152d0c624edf2ec"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "889ee65d8907ff5206b926c733929f74876ba3709527bb1225ba67ee1f653631"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c4444c557e852136ec8378ecff1b0729820f20965171cb871e9f741f8988efc9"
    sha256 cellar: :any_skip_relocation, monterey:       "253a4bcecad4a9b9eb52443de4726269d1418d3e100826fbbfac9c220934078f"
    sha256 cellar: :any_skip_relocation, big_sur:        "e6f08e63ff90136c50464804e274bb34ce0e53a1915a036946d3e6516bb160b6"
    sha256 cellar: :any_skip_relocation, catalina:       "e0dfd32a637620351b97f26b586c85c37bf11dc89ae6853e80d3af3babc2e7f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1dcc1a94c8b862c6996efed0008b126ac4ef2ef861f2037ede9bcadce97bd6bf"
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
