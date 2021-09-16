# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9ee70182476d0dc6caf37ac01f4c578f119004061bcf14b27512282ff56a940e"
    sha256 cellar: :any_skip_relocation, big_sur:       "74d3daab04a9dd96da56fa5cc9cc095228163efd2ac2e6fabfd962ed3c30fc68"
    sha256 cellar: :any_skip_relocation, catalina:      "6f2716bcd0190297a50a3cc530afd25afbb6c7da800b189e633061ac8fa7f86d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6e33dc84d1da011974bd2f5c1a8e948b1aa61ec7739d0e7ba16f820af068e770"
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
