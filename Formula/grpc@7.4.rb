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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "0c73c1938334eb1fca2a1aaf71c815378dc2c81506e0f8e5c1e7c73977f4b071"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b4f35e6b92a9241f628d1128bb6af7fa3400d8da91bc32c35eb40a8415a820de"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ba3e679e81a2c31f12727a95fe3662948b459e5b8425d81ec286ef6dd1d79300"
    sha256 cellar: :any_skip_relocation, ventura:        "5b1ddbc3ed2c581d015522eef328ca8cd899f05f4b3dd44c81061b24c52d4f0f"
    sha256 cellar: :any_skip_relocation, monterey:       "51d74d888136cc28ae8e0e30427efc25af85d7cb9e986d1ca2b57bff6a8683c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "77d977b8c0e9a75adb0d07f1ffc9156288147e70e22bbee737163836d8b30195"
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
