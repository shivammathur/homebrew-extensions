# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1d4b4b668b75902e95f5459737865f5eb059ab8d6b297b9a9cbc871f6c0380a1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c967fd53e038c62bae39a023a1aa87c044d62a70b39c73edfc6551d4c36b0642"
    sha256 cellar: :any_skip_relocation, monterey:       "621ff569e91e31537975addb90335a00cc9752fe7e91d509a7e169ce7ff5ec0f"
    sha256 cellar: :any_skip_relocation, big_sur:        "308edf33cb010084cb994a21b93d266dbc08d4de5fa3ab301bdef46d90c2ec5b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b72f3a2f4074198eac4ca63de6306fed5cae93a0dfdbdd1f7acdeb9e05b458bb"
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
