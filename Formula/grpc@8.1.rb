# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.51.1.tgz"
  sha256 "a8a79bf27bceeb8088c2a3a5a76c1146bbbd3e8d7a8a13e44ddbcfd715213ba9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0c1360570a0c5af22a8b8322e547f241e948fe1f9412d592750e015dc3a83fb9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "afef257f0a47be96e720075584afac09b0e38e98abd395ed1464f077ae8163ac"
    sha256 cellar: :any_skip_relocation, monterey:       "4c2497b91ec0516c997663beaad3443b242e3d5efc3d76141beb7f5b16851b6d"
    sha256 cellar: :any_skip_relocation, big_sur:        "a6ae84baac45803407d5d2c2066253f00a0d36a0ffd891433bf5cd22f8a7398f"
    sha256 cellar: :any_skip_relocation, catalina:       "817fe36f5c7215d63b9a2c65cf4622903c7be42c42a94868fad050ee7936aa65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e58f8c613603eb49e606bf56004a87dae9a3d74d3042e6449cf596f06775c7ed"
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
