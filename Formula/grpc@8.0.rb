# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9f9956043067d0ece2913959f87f8ff1dcde27a274a584fe21ce3cdcf1e319d7"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "87fbe1743ab86be5cbafae8824775fa6e7ac2aace07e99e40020444b2ad4445c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3940820c13aa57dcf9f373db3c051350f42beb9d61a5f84a47df5df7ec58677a"
    sha256 cellar: :any_skip_relocation, ventura:        "fc37b2e47e297a334d2c861b6dd7a8e5337fcdbe3a79976add3ad9b3c74f2263"
    sha256 cellar: :any_skip_relocation, monterey:       "ad85743b4a6ab646ae000484297159f390d3c59c71403d82671ebd87fbf06d96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b677a9f80ad27d6b34e93d9be51de61f8a36ed88dfd4b55d253dcd8ee95f4b3a"
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
