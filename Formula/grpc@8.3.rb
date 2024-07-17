# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a7ea822bc806e6c3197e2429a2139fd7b58fdb3897c58cc082f1026893456603"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3dc6b1564c6f91f977c049fa93a81b44fb9a3eac38554f10775f8ff16ad55dd4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d6fa73e3424ed2ad2550f30227e7cc9b99b3f9fc86ce813132d233544c04cf66"
    sha256 cellar: :any_skip_relocation, ventura:        "7b59d6440403106172d4aefa8562950c7ed91861d523306542623f7018c7a5b6"
    sha256 cellar: :any_skip_relocation, monterey:       "f1e2a2ad4207d7f9c0a5f1a13979ba8ae2785f11da5fc99b691361d4a16301f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9daf42718e51b89ea3f88be878c6fefa03d71de0b5aa5e5af9b688c07e2a59d7"
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
