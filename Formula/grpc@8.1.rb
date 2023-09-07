# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8e920f46b83ff61247530e40a8b13f53aa9dd5db4e3a1aa9772c0d73e7c70d96"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f2b6bb80efb6dc45884eff13f920fb8eae35435457a1c9d0516cafeca2cb6af0"
    sha256 cellar: :any_skip_relocation, ventura:        "7f0090a08b833bbbaecffbdce5e40362e71c0f2ed148b6f017d04825d0f79b77"
    sha256 cellar: :any_skip_relocation, monterey:       "e343084db00d56d8e9a1f1fe52606ef1f7c4b82401417b627eb64459287e08eb"
    sha256 cellar: :any_skip_relocation, big_sur:        "d264016cf017b40909ba04b2c3a740e2b87a0812b19ef3a55bed2aa88e8382f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6ebbdbc079dcf5873e3c6a944da0f60b9b932ddfa2721bb64a7a0cba2964ba89"
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
