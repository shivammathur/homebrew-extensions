# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.52.1.tgz"
  sha256 "f8ce3ec8ab3678c70d57fe60982dcb6562a6cc162718cfbe74783915b49803c4"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d0d08efebee325a99f2862e756ee9cd17fe0dbdc2387ec1a01ff9d0da107548c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6d928f7b3b3a1f534d9d11903fd7587a9fcc806cc123edf3a7329ad0248735e4"
    sha256 cellar: :any_skip_relocation, monterey:       "32a46ab5a92f62dbf5725c97d680d7a0d5f9cb5b1efb5159a03362f9e7857ae6"
    sha256 cellar: :any_skip_relocation, big_sur:        "eac99893ef886263a59a43d86d1e6b57a9a8a07807dc2e452460be85ca4a661e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f5c787b798d485502cb5e0be7312c262445f928c23245e3d2049be1e2287d30"
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
