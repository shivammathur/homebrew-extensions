# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c24e6dedea564f22c0dfd374c95500bce1c35c21def2be5f2992095c4d39fbc9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "93d1aa20724441c0f6ad39d60e1c95ce59d6e260d0ca33a472ab43940a7915af"
    sha256 cellar: :any_skip_relocation, monterey:       "ecd5c7140113841c17d3fc062b29ec4240b74926dc5ee6f250c16d167179aa99"
    sha256 cellar: :any_skip_relocation, big_sur:        "b795e2dfbf64955e0f88dc7ed860e07d4fbed918b16ac98c00c9efaa6dedd762"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "14ed1eb013b700691299bc58aecc20e97e60e047607ec77a39048f7404f8b0e2"
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
