# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7726d905995386951094abfe317891444dd0b954d30569b2641f99fe12e11531"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e1efe5b9d32a25f63e0a624628e1d165ae71c7583e646e8d1ea83233d459989"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "68d9a416122c228f51888d20de81a19a135eaaaed0d1c32257b416eb5885d540"
    sha256 cellar: :any_skip_relocation, ventura:       "2c547e08d25f8465cf75511aba54c9af0c1e66af1c95871dccd155795557180f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4d3de7c864668be935ea115008cd63f07c2ab29155be3bdf98c09fd81fd024fe"
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
