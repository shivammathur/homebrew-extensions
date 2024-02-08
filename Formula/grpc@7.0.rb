# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "92c5d6e78adcd3f32109ab366195e3534cc4fc220d8a334b332663db934d81aa"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e57d8e546f01e371235dc9eed94fcf474db3ba0349f80b576e8d4521bfda4bed"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b21ca061a827c6e1bda9995df7a9bbb7213e6dc27ce76222b918ca63748d9720"
    sha256 cellar: :any_skip_relocation, ventura:        "91962ccc2233379e77b9354c940037989cd8f512697ea999255c05e4b87cffea"
    sha256 cellar: :any_skip_relocation, monterey:       "5b8659b5aa3d61c8c2495c659607d44be7a36db1efd4f17bb9764f20535d866b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a3c126710ee0e376991b6d9528716b8f9931c0c47f2289f3485d01f3c7498bc"
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
