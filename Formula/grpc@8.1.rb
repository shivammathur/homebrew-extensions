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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6f42bea4590d864c47bb2d9f8bb8cf0eb71232877ff4b59d3a764d6fc5edc3ed"
    sha256 cellar: :any_skip_relocation, big_sur:       "6d39d7f10f0574e7074813c6538dfa4bea1dda9a3d6d558b94f0eb94621431c9"
    sha256 cellar: :any_skip_relocation, catalina:      "1e264e0e09e3c40d287d05cb9026978e304d93af79cb9d65bffccdbb4060f4b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "873c956b241590b77ea8b1f22dce59ea2aba2df07bdbfa439b09cbfe27669406"
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
