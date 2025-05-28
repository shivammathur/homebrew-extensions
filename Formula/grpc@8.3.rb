# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.72.0.tgz"
  sha256 "715fe230c0b185968e92f8f752d61a878f9eb5346873848e47ff65d0af6947dc"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f35a9b3e9b9b0ea12cfbf154fb81eef0a9bd3dba73878646474e8bebfda4b717"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3d84cb12f7b6914025ea895530b02358e6221e6d9a82dbfb1256a8245b210fc3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d2dea4a6156e871c30b5625d79d95a2932218bef2890dc6904de8d97284d1eed"
    sha256 cellar: :any_skip_relocation, ventura:       "bfbddf2269d4d1cb0b02b019c333471e3967b62c2d5ea5f5b0c24c952076be6b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8097d3c0e9636906560c1c711360a5461a052333ec0016ef3e32b17e06969a8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5715b44a17df180076b3a6929861373855eccdfc17d9a58d940d383098cf28e1"
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
