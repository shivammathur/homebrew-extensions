# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.39.0.tgz"
  sha256 "912bd2d2bd9d5b6e2ed861a79316a14811aac6f8e1a93c82dfc993430639d004"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4e0e700e9c63aa3691cc3cec4d4ffb220c02f78153b5175419807f75d2003ab6"
    sha256 cellar: :any_skip_relocation, big_sur:       "cca80c66a5a3894df3efd0f60d9a8e71a25524b8f7d1da97a36c8942b9abb1ff"
    sha256 cellar: :any_skip_relocation, catalina:      "98891003d2d2e6c7fbafaed13f87c6b728cc4f267f7f6111e10a5dfca722e348"
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
