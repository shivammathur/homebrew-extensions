# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "e56c0e7eb00a586918861f144d6769c23304593b699c70a0906d34baa0694b34"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0e2390225c0dee9cf98023a1801a45f3fd558ddaf5de04781d7b5aeaee01d0dd"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "810e66126f8a3adcba4cb8b1714c9655ddf5c12f471024ca40df59d35571e457"
    sha256 cellar: :any_skip_relocation, ventura:        "734b68ef25881eb7a91f3424c1326d318c1cc393b0c30c1c4aa7be8c798d4a17"
    sha256 cellar: :any_skip_relocation, monterey:       "3992ad9c90f1996705d218e7c25b48a5fcbb127936e1442e253c3352091f9dac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "41dc8d239117e45ddaa02f281b43a32b2ed1e761247bb1986d496d1e08e60b0b"
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
