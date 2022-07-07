# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5bfbb5cf1ba2324387263f7b8aef1ecfa6a47f1e8cf65d4150ed92f97ccc155f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2cb6b9ac4c8acf9d3046324c22e7bfdc8b728fef498c7506ffeb0de266fecc9e"
    sha256 cellar: :any_skip_relocation, monterey:       "4ff745f64f559676ac45601ee49651052ef8f16070fbcebe5167e7cfe3caa310"
    sha256 cellar: :any_skip_relocation, big_sur:        "99ca15a562cdaef97b24949cef54cd5d4ed1796c14560ed790238f6d4dcf7282"
    sha256 cellar: :any_skip_relocation, catalina:       "af758bf337efb4ea3ed9f17dbe78286a3a1ac0e57dc341a7aef10f610efe18ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d2b9aedc0ec66bca43cce271e95c1ded4154a248acc68b9e9351a34a85475556"
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
