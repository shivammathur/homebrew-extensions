# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7f994e9cd02df97a8add443fe16c9a1fff637c73e91c6143709fa51da0841c6f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bda4df7d0f00d888c94c86e0fe9a15fd570e97e14c89d46f0c6a0dda7a4b5a27"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "54f2a1860f7980f0318e0869428b785ec1b5d5e11e78fce9796dc74dd54d1edd"
    sha256 cellar: :any_skip_relocation, ventura:        "acb0492ab6b9be72f01801b40db8162badfd51f25af5b8a388ac10fa9c0ad648"
    sha256 cellar: :any_skip_relocation, monterey:       "f679f0debba3912964cb83b3a41cbd05ee34c4443bc40afd90f3b29e445645a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "64ca8c27e86e4f7f1200020f0334f6154b4d7fb9e3e6229169d2ab5a545e8b28"
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
