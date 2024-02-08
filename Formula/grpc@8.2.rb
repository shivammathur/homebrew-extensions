# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "cd1207185889ca8e055ae602d77e124150e9eb6382fd0b470acb2a7649a9b89b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6bb56a34f97928ace0212ab754dd32075920fa2b3502990ab976fdfc6782b6e6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3b6388a43cd1c3972b5cd899368a66818af3d98eacbefa353403218b7d521fde"
    sha256 cellar: :any_skip_relocation, ventura:        "a274dc894b210937c5fffe38d37b8efb9439859fef83b35910061fdec33c7ac3"
    sha256 cellar: :any_skip_relocation, monterey:       "1f615fd49ab0f818996a8147752c21919a98172354c395234db980a9d5dda947"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7e8677d96f5b3f0cd29a5715dbe5bd2625dc0d23328a4d95f78bd5fb95f81cae"
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
