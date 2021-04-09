# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhp73Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.36.0.tgz"
  sha256 "819becd24872b95c52ad1f022ca71f6f5eed207605b19a26e479b1d5a62c8561"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "808684fa915e04496a67c4a258ba4e938c171219e8e6c7f87c0fa9cd936bcd19"
    sha256 cellar: :any_skip_relocation, big_sur:       "d5ad05d712fefbb0f40c912f3dbc65e07b3e0e27d9c081aaf7bbbdb50c3bf3a5"
    sha256 cellar: :any_skip_relocation, catalina:      "3dd92c0dc79233f33ab987282abfa63cc828c76e4d3be554dd6b6a2703d9e95b"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
