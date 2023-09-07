# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b0ee5fc31d1d3ca16fd9e95feac670261ce24f535f991b4ebf81b06f240cb451"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "eba27a24006bf490758a2d9214f182816cbb5c6adc6c7ca2a9c948715102f74b"
    sha256 cellar: :any_skip_relocation, ventura:        "06cfa3d4bdc1bf7ba3204b143506935e401b793fcc269b60d38b664eb2139115"
    sha256 cellar: :any_skip_relocation, monterey:       "d6d35bac18c7be064f25a905c58c390ac6f7688828a87359fa679f53ab7b6e6e"
    sha256 cellar: :any_skip_relocation, big_sur:        "ebdbe8047d3208bd705274fe167cb267746aed69ea0e9d2d53812b8e039f078c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f05217c102533e779d71c01501671382e3d8e631bc158c11ed81f5c72c2bdea2"
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
