# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.44.0.tgz"
  sha256 "f6d6be7e1bd49b3aae7ada97233fe68172100a71a23e5039acb2c0c1b87e4f11"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c709f580bc4276d4c13699329d995bc0bad642b0e990a6679f5f09306c7226dc"
    sha256 cellar: :any_skip_relocation, big_sur:       "e5f5dbc47514debfbbd822198599d70f85ea6786b67c0031841e94a23cdbd68a"
    sha256 cellar: :any_skip_relocation, catalina:      "d924b3a4b5066d2bc735d1653cb319733e1122a938e0c460c91572f28063dcfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c3948a9fea3e8032871162437df78cd779e933f70a6b749ec8ec2316aa11ef94"
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
