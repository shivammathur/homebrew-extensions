# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.42.0.tgz"
  sha256 "a7b9092534555ea4ea0ea79c1333afd088569eb5865b941a4a610504e387683a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8fc5bf519e33b2eb5fe210125afb24654ac171cb10c36209206e81d1b3f573eb"
    sha256 cellar: :any_skip_relocation, big_sur:       "c0e3b52527602d297b2dda1fb0a767eeea9ae96a6005664ea1741876da15347e"
    sha256 cellar: :any_skip_relocation, catalina:      "600991f2358070201d3257648e52bfff62f3cf8f65384964db87f1992c2d667c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea2b7f0af05aad2a52656bf80ddfff91c61e3a94da85bb31c549d88f1f67fc2b"
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
