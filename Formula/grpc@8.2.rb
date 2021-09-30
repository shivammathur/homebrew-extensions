# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.41.0.tgz"
  sha256 "62d7320d7e26db29254bbc5770b70ba1f902952b9c6f89d34461019e7f8086a2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8e0741e4f3e68ff77c5c0deda2883a91127df40af8c6bba09456e70b8afb899b"
    sha256 cellar: :any_skip_relocation, big_sur:       "ae18612fd80af1155611ededc145a518edfaa9243d759398e9ed8a9f3b8810cb"
    sha256 cellar: :any_skip_relocation, catalina:      "9b3a811fbddbadbca63bb13bd5a475d6a0e29952b59bbf3a7ca3134805d1438b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ea990fdba3ea58dd8e7737f563ba4d6296a7d4d7154490145e56d71f7299e7a"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
