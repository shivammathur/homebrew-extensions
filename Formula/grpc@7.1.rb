# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4731f7a6d57ec2c163055aeac166a882492963f346dfd664ef319048d9d3d924"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "de7a1e68d1e8071cf6999f7283eafdfb4f9a1433f2e4f89ba8c7345951669397"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d2713e4b252689350c534aec46dd50fbceec93d139d4188ec7f1f5af7c7b1a69"
    sha256 cellar: :any_skip_relocation, ventura:        "df228321f1000c83f14ea123f571be1c3a5915cfcbaf24d46b4f80fbc53c7376"
    sha256 cellar: :any_skip_relocation, monterey:       "e975a87821dfb8b033865cb3553ed52c9b81459a132e1ae030ce58d2c7c8150f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "abbcbd82a0f58339dacf0c13fb3672285c1626a9c65fb2e8bfe529e8cb844a07"
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
