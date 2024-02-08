# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "463f00599025483b4db76f25d72dc01c7108192ca9a70300b368ed6fa282d9e9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "aab228469c4ac8ef2b4122f08977af15b2a90762b867303a7de48b35192b6899"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "28d43b78501b83576859e507ce9d2724fc7401d66fa7ac38862f3045c26e063e"
    sha256 cellar: :any_skip_relocation, ventura:        "cf12d95f835570af0a7a43bb187193530b3074272ca75d98abf660a9e72b515d"
    sha256 cellar: :any_skip_relocation, monterey:       "9fbf65dfeb5cec198f8c9c34ecd17a48d75d9f8c780fb3102f226bdb3dcffd7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "92cd25886d6dd232211827e74c7f4af5af8c6e2b103873b1870dd9516ceb0e15"
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
