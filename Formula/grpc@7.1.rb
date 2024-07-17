# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c7ef240afdb9916e1193fde18d8e28b0a92920b677c4c24143621e990ec75bf9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "91d6cac58035cdbab1654c6ba6838267f1baea213b83d35a226ac3278d322f6a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "13a1d4bac1e0c145ac1f5a9f2522e2744ba7de5b288ef1294c14b224601b946c"
    sha256 cellar: :any_skip_relocation, ventura:        "ca594d08118906e665dfaab650d93d375856f1aa70c9c7335f1aaadd3e9c789d"
    sha256 cellar: :any_skip_relocation, monterey:       "03ffe04dadfa02117d7a544da36ed0963bd1a84c8071f9a043e40f13f244806e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bc286bb0c7456fb9ff2496245aebdff3bb83d347e1f85fd8ea4a3fa4fb26dc88"
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
