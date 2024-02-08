# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2faa19ca5eeec17d421815cb2c2d0fe22d78fe63c51c472d8d273163b2d8f35c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2a604ff06d014fd913de34e3be194d3308d3bf17f442b76b6c72347254c0e294"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7b0527ebc3db4cd80e01a875c2a5340cfed2c8ba8c4465fc2b22cca9a8dbede5"
    sha256 cellar: :any_skip_relocation, ventura:        "32e521ea3818ea1849ccb6686859726c61cadd1fb44cb5d859a0cbe9edf0b2fc"
    sha256 cellar: :any_skip_relocation, monterey:       "203acfcb9de4b8717fbfde36b87bdaca26010ae31fc159dfa94397e65d836065"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb19fb87b96eb52197897b31c629f115c8b54183ac21725570297e64c627f2e4"
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
