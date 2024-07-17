# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6ecd90c1c1cdb4bc57ecf9517c38336ee99afd81e7ee0decaf48704e4e53b531"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "36efb7758e59330d1a2c7d89e59a7c0f339361955115b8c7a256080220b1be95"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6ef5bcf99cc22b8a992a1c1fbc59eb2e868d901e9b5865a0123f3970e317a4d6"
    sha256 cellar: :any_skip_relocation, ventura:        "44c0e505d50f3603124aa2834be8a1ffdc20c5b17d9a3360c135e4093848132a"
    sha256 cellar: :any_skip_relocation, monterey:       "ddb672e1e3f4c45e6faa57cbfb9fac96dc58a6adfde0f2f527f873c14482402d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e79962a981b7124afb2f10f66452b8b22d23706fa92da75a61ad42265b1c228a"
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
