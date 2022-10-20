# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fc5dd358ffff58eebcb05b1e352575042b40c05c6db7d914bfb710f87cce1cf1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c8bad907240c28d6278aae8b816303eb3ec98ec6c7ea76868fcb806bbf964aaf"
    sha256 cellar: :any_skip_relocation, monterey:       "61e2ba0253fd1353bffcf09d3981ab7df0e8b576db318222aecd4eecbc233a61"
    sha256 cellar: :any_skip_relocation, big_sur:        "f7debc2dd9d23c543a326a43cc06e3db34b4cf98466e978b1e523ab68e80c24b"
    sha256 cellar: :any_skip_relocation, catalina:       "5d4b41d6d083496cf0691d62b23d7e912ef2afedf015c59be20b1072d0f3e805"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4df91b4dfb90f3db6e242dfbec572fa025c02092ede195f2c064e7dd2f6e6e9f"
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
