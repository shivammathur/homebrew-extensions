# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "60e6eb03b95100023c5fe1374cc3af4a757be1104a1379fc0e9eb70472a10754"
    sha256 cellar: :any_skip_relocation, big_sur:       "615e6585e62862768fb3b30ce10ab6262c453edee4c393f9cb82344633e35dfa"
    sha256 cellar: :any_skip_relocation, catalina:      "ba540737a3588984b888afcbfaf6ace49a8fc60317e8460c6df09eb6d4abb4ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b211d876f1102ef1fa8d7145cbaac8f62fdaed7767b0183f6624c24d8f75fbce"
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
