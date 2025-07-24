# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.74.0.tgz"
  sha256 "972ce8a989f2c15a951444950c1febe84eb88e59aeaca29d96e005fe55df1fc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b4129909e70f3dab438e34e36a4a7b6cc8aba1fbbeaed358f3beaf13d4540a56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0d3db5b86717f9ddbb54cb116c1bfdf82f797ef52cb7907824346b405ae839ef"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "26955b53f422ef42f5d291a8bc41fabf23fa25b847a4f5fb46d1ed4de109eabc"
    sha256 cellar: :any_skip_relocation, ventura:       "f164b7012f3ff9fb7c11c5f80ec29d82dab32aeaeb8a7bee7362c03665c935cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eeba2d0c1e1eb4b0e5eabd21fa2a67c546378f5f27e97b25877d2e6155933f8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "703d5c6f8f23153817e396355b8bff1c88ece60768ca82cb9d3c7a06dbc22e42"
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
