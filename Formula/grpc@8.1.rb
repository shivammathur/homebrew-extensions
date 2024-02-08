# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "011f9bfffbde3b778af3f66354839890b6731969ac653b79964659c420d14aa8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4aa77e115d90bbfca77c232706422bc13ff5289cdd2c0af2b05f0c02c61c75dc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "203c8cb21b835577738d524a23dab1374e0400fa1edd78599fe252e4e3dfed9c"
    sha256 cellar: :any_skip_relocation, ventura:        "a07c6747454835df2d223c6b515aa63a3aeca1efe54e6bf45d4c95530910aa6d"
    sha256 cellar: :any_skip_relocation, monterey:       "7020b0e423ca13ab22e9dd3b13410cdcebf7e6c51fa7caf28369ca3a3653ae8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b016800ee9ef61eb0d340c20a92af252be91f66153e46e77eb51e27c817d52a4"
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
