# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.0.tgz"
  sha256 "3eae67ce7c8f5e861a9b5472542c541e094bf964f3651f4ef015487640afcdca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1711a8b4a1f060d518525903a3358305471e82bfdeaf1ebb25a3500d2784e716"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "abfba9b1de3cd1856b0938090461f8ef87f3459238c551e9b9bce2295ad2413c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8d3ceafbeffe2715b148a9b2622e0dc75221143d517e5946ecf2ed84c1b63d75"
    sha256 cellar: :any_skip_relocation, sonoma:        "45d214e0a73940b83c454f8ca208f36e1b9da3a9606440a031d30fc3302916e1"
    sha256 cellar: :any,                 arm64_linux:   "63a00e4eda47601ff2a39262bc9888b89a29477ccb948517a053b1500d73424e"
    sha256 cellar: :any,                 x86_64_linux:  "4f6d988e26319862447ddd7ef99ffee40d87400d2be79945fa16a6c880bff3bc"
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
