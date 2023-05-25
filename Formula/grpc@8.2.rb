# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.55.0.tgz"
  sha256 "75f9a465a4d1f6f337aa5dd83e5b5447064aa0a2b2776a72ec192ad7972c8295"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a44099d98fbd5fd6b5d5391e3fc0dd26b6732e4d9a3f6ac82c0d8e3bc83b30b9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b50653f87f943f11faaebf6b5d2ab40928cc8bd272ed6d9f50d11b8c353a4a1e"
    sha256 cellar: :any_skip_relocation, ventura:        "851a9ba67dc421ea958810d0bc372121ad4e34c218d04f4e4efbbd7f37fa9cfa"
    sha256 cellar: :any_skip_relocation, monterey:       "2cb89930d7dd74eb5d7f6031c2984c95404275bace2562df69844decb9b79513"
    sha256 cellar: :any_skip_relocation, big_sur:        "c60b0e782b823a32c978b3de05f8e503ccf3862d9437863e328c9a7f3745c705"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "72656ba3e7d98bcbf17a580ad39001717d69e6cee78a65297a47d39cc62f249d"
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
