# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2e38b2f5bfd10178cf48b04d6afbeabfceaed9735754be3e1c388f94ce07b06d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f4f55683c21d1402a8dca10f219ce32af565a54d07dcb1ccce3c6ff55bb02e50"
    sha256 cellar: :any_skip_relocation, ventura:        "8536512a2a00603cd4f5b567d33e54c8588a0e6fa21e951eb97983914b393f13"
    sha256 cellar: :any_skip_relocation, monterey:       "49afb1cc547f1da326ba3fc62af796c8fdf5bb4bc874c8d44c931fa99a8e58ca"
    sha256 cellar: :any_skip_relocation, big_sur:        "cededf62a60a84844206c2f9693937d0271ed958bc9c56cedd5302255695beea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0e124cd15783dbc9d690779f6d429c42a1ce207e0a1f48636ffc87343146b0fc"
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
