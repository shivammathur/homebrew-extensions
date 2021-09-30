# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.41.0.tgz"
  sha256 "62d7320d7e26db29254bbc5770b70ba1f902952b9c6f89d34461019e7f8086a2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ab23a33af1379683fbf60cb9a6b92a6507bd2783698c0a8b8dcdb9e3d861d51c"
    sha256 cellar: :any_skip_relocation, big_sur:       "83a1d2b9300e5deb773f30d02e8e5ad8fec3dabc8979d79e26782219b13daa8d"
    sha256 cellar: :any_skip_relocation, catalina:      "20b5aaddf24f26788bc948a959439f1ca4dbaa955bdbc6c739a2234149e6bded"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "778955efb67d799a127a4bf81c5e9ffc8d8bba9a2a96d22726aec0920c8b4420"
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
