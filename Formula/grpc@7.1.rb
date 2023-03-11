# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.52.1.tgz"
  sha256 "f8ce3ec8ab3678c70d57fe60982dcb6562a6cc162718cfbe74783915b49803c4"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bd0a5ef706f0221c1f681897e428b7e63aabaa9a820da6479ff91804c5d3a81a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5619d2ccd5323e8b15359f35bfa8d8eebdba2700e67ba5ceff6fadc24c4f9518"
    sha256 cellar: :any_skip_relocation, monterey:       "fa4eb592741a79de8348a62708600d4790c9a4dcbd4fa79a07ef466a4ca1a685"
    sha256 cellar: :any_skip_relocation, big_sur:        "48d82b2bcbb294c93fcbc7e27541199b60b8ea2468ac6c518b3bf8ad00a45ca5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "129f547ba7462c310a4dc9c551c610e8d42d785e7ad5f4a3e1cf74eef57f4c4d"
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
