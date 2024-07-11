# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2317eb2552c2778d89c38436707f70415dd5278c2d3f6a7c32df55a79e86e955"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4e433298ab6898bde4f81ad0dede00ec192da851a9edd4b3e72d34b615886a91"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d41ee3ec32ab5689001341513999c4f207cbb5346986a7d1a0835858e5dbeb2f"
    sha256 cellar: :any_skip_relocation, ventura:        "cad138fe0bd70cebac9ce75ad0e4e0d38002ba882bc0288eebee2667f1cde124"
    sha256 cellar: :any_skip_relocation, monterey:       "46dfd9d90e18ebedd3101f459c77ed88ac04790b5f832e1be99ae19e56809588"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4a181f189c492c8de88548cc88d318431feaba4ebbd569d90bba8432512f98b9"
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
