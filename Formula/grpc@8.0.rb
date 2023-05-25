# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.55.0.tgz"
  sha256 "75f9a465a4d1f6f337aa5dd83e5b5447064aa0a2b2776a72ec192ad7972c8295"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "64bdde3b5b4f5403da5d2d0f133dbb8c2f732cf3402c36d09fa1c2158a6cb943"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1367d010e480997e9ef81c4081186c8afb70e6779866c5066256017c4e6d5b3c"
    sha256 cellar: :any_skip_relocation, ventura:        "6f6097f8a30294dde43e43663c93f95525afde3e7694d715a0c02044bdb0bae1"
    sha256 cellar: :any_skip_relocation, monterey:       "28b3e10ee3b4662a4e404861dce5224ce9557f6d15e5b9e7a9b0c477ac600b6b"
    sha256 cellar: :any_skip_relocation, big_sur:        "d33517816fd9146719c4a54be82950cdf53009ed911f63977e705bfe1cd88489"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6ba70e6751b896bc632ea705642f73a3ef4c67bd849d020e1747bf252d8c759e"
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
