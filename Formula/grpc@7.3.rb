# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.39.0.tgz"
  sha256 "912bd2d2bd9d5b6e2ed861a79316a14811aac6f8e1a93c82dfc993430639d004"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "20689a4f7b9d3ca5607546a52b116ebbc13de6c0aa777662c35ee336957acdc1"
    sha256 cellar: :any_skip_relocation, big_sur:       "d15bf75eb5d9ec01a7b290d71c59987e3d1a0a8a25d59743ebb4393986cba3ff"
    sha256 cellar: :any_skip_relocation, catalina:      "8d7eaaf4d7182381d8327ad8a7e78fc655f4ea513209a5a5f5fa30a27fc8d833"
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
