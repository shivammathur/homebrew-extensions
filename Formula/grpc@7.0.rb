# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.2.tgz"
  sha256 "5efbfd399f3be464e293bb0ec4a773fae9bb4a43b67362e1fac72bb4cae4bbc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "65640e72a27451c21c5a0851d95b8be4fb83527bce5343a5cd88cd769f78677e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3f6efb1b9c621c332ad4ee0a40227e0d9fc31b42dd16f3513c70873d50e1ba04"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "234e233e4ddafc1ce868b3f8bbbafaeb45503a673ec42321715e9635d77d58f6"
    sha256 cellar: :any_skip_relocation, ventura:        "37a77745fa5f6023a2cb29a525e3fa1bd67af1ca3b99f974dc66ea8c190422a8"
    sha256 cellar: :any_skip_relocation, monterey:       "751f50d8d43fea1d99a577a1feeec3df44672236b92f102efc74647155705ff1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dfbc4ef589258a076fc410ed4ddc81e01ea02d29b46e3b88f164af574d9a7f83"
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
