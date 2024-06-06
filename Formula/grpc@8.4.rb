# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.64.1.tgz"
  sha256 "7eedbce54e29281d8fb97b0924e34d6cb315c5ba12e8a55706ccdde977497d43"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "df023c0d8e3da140ae015927a253072910706725d3bb3eac21f438ba476c5985"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "010eaa72d828e7255b3890088b88352ae26f90458a95deda22bfcb4b428ef787"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "26e4402839a295627f215cd2b6928350d18e19a641a2646fe3e05e42351251bd"
    sha256 cellar: :any_skip_relocation, ventura:        "45ece911700e5e7c75068655df32412fc14b77adcd5f4d082a00caf50889d3b4"
    sha256 cellar: :any_skip_relocation, monterey:       "bcb1140c3b6605d78d802afc42d33b1018da4ef88d4f850b6c1c348497bd576e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f8c59422c11a264947f119c9f34251be7f4b48f62c469fd942972181d483b8d3"
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
