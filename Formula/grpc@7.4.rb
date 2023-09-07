# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c819a4943c5e1a7aae04ac233a6d015a62d9bd5194c3d342d961d1251efb5ad7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a56a8c4ae1dc40543462f441bfe669dc67b6b654fc61976f20daa3168a508a11"
    sha256 cellar: :any_skip_relocation, ventura:        "4b049fac24b166a3b22bee92cbd8a29891f1d7ea8112196bde1bf0aa850e0a5a"
    sha256 cellar: :any_skip_relocation, monterey:       "dfc5b0c430a6ecbb8b83ac67924e5a66c08b20b036dc3fcc0e4fab61481b0fe0"
    sha256 cellar: :any_skip_relocation, big_sur:        "73a65eddb4debf85e2de275ba05803c599fd9bbeca38d450eab4f933e22d078c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7ef9f231e76c65b6fa4a2f59ea4c2cf4c5760805b7fa581e0d41f28a70c8a6bd"
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
