# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5a6a26115dab02e9b5fdac2d8555a804a08b3bdce0d8bbb22b67634b493fe628"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8d0b3289deb800f50410dd30c54e3d90a3db7f20f61b453c6aacf39ec056706f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2c8717c71f7dd1efe88a337acae71e51c7936342b65e21aa3ee0f7c4b15820ab"
    sha256 cellar: :any_skip_relocation, ventura:        "fd11a401abffc61efe59bb98e9aad359edb6ff2c94769324de1bf700f0740f01"
    sha256 cellar: :any_skip_relocation, monterey:       "3b6ef3e52db6372ccb924f0c31fe42193edee718164622c406b8a0423e8522af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6cac62200c2caa5bcea428ba6f212deec1ca8cae13d0aa4374cfe4663b40e6d4"
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
