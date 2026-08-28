# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.1.tgz"
  sha256 "cb06519b1382f57ba6f5358504cb37e933d5a5892553300877fd4f3b04cf0560"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2b4dfce228fe90dc914454a132832b248a08c21698636a3bae751037067c17a7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4c48977ce2ff2d3212b22c9545cc0efa547a5c1d620115c87260afa44980405e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b550a5e1744733e085808c6943d9127b869807f1ec1a7fef982f107e04b4d646"
    sha256 cellar: :any_skip_relocation, sonoma:        "ea15e75aea1cff34ed0e0e9157437ef7bb575a9a896e62f1331dfb8492910cec"
    sha256 cellar: :any,                 arm64_linux:   "be50f4b29f8bd18e3ed53b697ec27647fd8412a3acf46ffd5d9c50e0b75a26cd"
    sha256 cellar: :any,                 x86_64_linux:  "36895d660c8b2d811643160c45db8491296d560e65e55375db8038655e70897b"
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
