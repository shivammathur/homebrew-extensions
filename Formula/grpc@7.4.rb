# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d1ee46a46bf06b58a2b5676b912b3398e1a6667b71d8ad162a7d0f811fd69fe4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "375c26c374f15fdf3e24467c3088944e053ba4bfa87f6e6b6587b0b781ec49fe"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "04071c4d5bd6787fa22be6b52f309ce60cec9d1f4f44e8deaee38e23b51d07bb"
    sha256 cellar: :any_skip_relocation, ventura:       "4617dfee95639405c3f7061ca7e4141027a84f4571f00b6de17dba5caa55f344"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d591395c16b72f3eb45b68c7a4655fd75762eec4dd1505b0255c2c41ac4b692"
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
