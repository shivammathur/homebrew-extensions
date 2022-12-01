# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.51.1.tgz"
  sha256 "a8a79bf27bceeb8088c2a3a5a76c1146bbbd3e8d7a8a13e44ddbcfd715213ba9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "22e0b2c28877555a2c312267264bbdaeeac2cdbd228152f667bd110899bf762a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c2f3f05f83a3bbb67c7fe4913e9d051113744837df64303e85def13e395b52fe"
    sha256 cellar: :any_skip_relocation, monterey:       "8f16c680e97a651f51993811625808d6b3b0ee2feef7bcfd44ea29fd0f107f56"
    sha256 cellar: :any_skip_relocation, big_sur:        "2e65822405814287335b8972058151cd911cef2a4a508b3e8c68808c7d76b507"
    sha256 cellar: :any_skip_relocation, catalina:       "ad20efd0116b0c7420428261d341be5e1cf5ddc221f54ca398466c5b6ccc91e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "033d8fe357d5440b2012ceab397f8334e830e95b004782afb8b6075f7dee6494"
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
