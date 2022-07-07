# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "73e5df0d4fcce78a36b40b95dc8b445ab92b17aa2db7d24b20399b60078ada0c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "49888028ee25be779ec331885e60b15f027b4c5a08be7f40e35aeef625fe8e0c"
    sha256 cellar: :any_skip_relocation, monterey:       "4a6e752ff1b72e3bca5202c0bdc1ccf8615b68d9eaaf39d7ef9a4267eff9bdd2"
    sha256 cellar: :any_skip_relocation, big_sur:        "482c29ea91b0a1f21a2d8ac4b26489352d02069e2d5ea38c49d16a10d6514ec3"
    sha256 cellar: :any_skip_relocation, catalina:       "cc6b84d0630a4db9ae208177859e16b07bba43f6bce15ed4bd42169834c8d9a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0fe6dc3205ddb3baf0069e575637bc236d5d03961c18f6815dd779e9c4150743"
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
