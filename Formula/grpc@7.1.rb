# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9da752613d01c626330db5a8b158a34b91eabd7ad6e1ecda5cbbe382de731c23"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "08fd86435aff02d9d89aef687f42324a16344cca0c577856bff74e9e37472a9d"
    sha256 cellar: :any_skip_relocation, monterey:       "b4ed5f38c2ad9563b75b44913112912c303773642ae0c24e7cbf3368aa4b666d"
    sha256 cellar: :any_skip_relocation, big_sur:        "7c54b6848f9e00a9e4b2c7a539104fc980ccd53117fb2211c587e700afee9b90"
    sha256 cellar: :any_skip_relocation, catalina:       "c966dbaf72f68a32b232a5f7d6e651d69d807a40146c4535cba58ceae4e113b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "83e96925af6cd086a7d3b4da00d79620210fdde69b355e66822ee68b6c6d3ec0"
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
