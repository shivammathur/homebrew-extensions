# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "22c536b3d10343a8eba0eeb4f6a098d73626f01f5a92856c2fd8c3f9cfa5a447"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bc6da7aad141aead0da437a54b6074b2b17eb3bf4029c2617f32a18a9ef975f7"
    sha256 cellar: :any_skip_relocation, ventura:        "d218a1ba50a5f4dafdf30cc05ff53714e0f4539a0472b642f2a67c047faa9cf4"
    sha256 cellar: :any_skip_relocation, monterey:       "94d2f40c195e44a863fcf7ba5a6eac7dc0a90a6367ac68fa949246f979869d89"
    sha256 cellar: :any_skip_relocation, big_sur:        "d3c19bd98c6a14f2a2e811ca8d4b750295da748a391bcb02ce62e3dbdc95d162"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c68db76e660e7f6c232c7467d85b45bee5ec541c36e5d0a8264a4865dd4207f8"
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
