# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.55.0.tgz"
  sha256 "75f9a465a4d1f6f337aa5dd83e5b5447064aa0a2b2776a72ec192ad7972c8295"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8a16a419d1fc8d29547f6029bc8b28c1aaf1ed759406a0200b4dea8822d81c10"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1c2a139fbf99b8684253680819635ae5ec66c4e6c1a58f5aeff8f89b255cabd1"
    sha256 cellar: :any_skip_relocation, ventura:        "ecc7f6541c3254646f9b4700ea764665094c5e854cf0614952832bde4d85e23e"
    sha256 cellar: :any_skip_relocation, monterey:       "9d71b71858bfbd4368d83888c86e7eaff9430b71877d2e4d6cfa557c1b75028a"
    sha256 cellar: :any_skip_relocation, big_sur:        "d3ed637fa49c45d925ffcecb7d0b494df96e293be700bb9d0774b05500ab6a09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0986e2e9aa8095c4db03f9e8f6bf43e992fcff9e080d743d20de71106c075e61"
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
